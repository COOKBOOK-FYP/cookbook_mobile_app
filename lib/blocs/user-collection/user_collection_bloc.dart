import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/controllers/Firebase/firebase_controller.dart';
import 'package:cookbook/models/User/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class UserCollectionEvent {}

class UserCollectionGetDataEvent extends UserCollectionEvent {
  String uid;
  UserCollectionGetDataEvent(this.uid);
}

// States
abstract class UserCollectionState {}

class UserCollectionInitialState extends UserCollectionState {}

class UserCollectionLoadingState extends UserCollectionState {}

class UserCollectionLoadedState extends UserCollectionState {
  final UserModel userDocument;
  UserCollectionLoadedState(this.userDocument);
}

class UserCollectionErrorState extends UserCollectionState {
  String message;
  UserCollectionErrorState(this.message);
}

// Bloc
class UserCollectionBloc
    extends Bloc<UserCollectionEvent, UserCollectionState> {
  UserCollectionBloc() : super(UserCollectionInitialState()) {
    UserModel userModel = UserModel();
    on<UserCollectionGetDataEvent>((event, emit) async {
      emit(UserCollectionLoadingState());
      try {
        final userDocument =
            await FirebaseController.getUsersCollection(event.uid);

        userModel = UserModel.fromJson(userDocument.data()!);
        emit(UserCollectionLoadedState(userModel));
      } catch (error) {
        if (error is FirebaseException) {
          if (error.message!.contains('Failed host lookup')) {
            emit(UserCollectionErrorState('No internet connection'));
          }
        } else if (error is SocketException) {
          emit(UserCollectionErrorState('No internet connection'));
        } else if (error is HttpException) {
          emit(UserCollectionErrorState('No service found'));
        } else {
          emit(UserCollectionErrorState(error.toString()));
        }
      }
    });
  }
}
