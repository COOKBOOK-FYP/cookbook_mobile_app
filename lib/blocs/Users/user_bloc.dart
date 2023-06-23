import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/models/User/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class UserEvent {}

class UserCreateEvent extends UserEvent {
  final UserModel user;
  UserCreateEvent({required this.user});
}

class UserEventFetch extends UserEvent {
  final String id;
  UserEventFetch({required this.id});
}

// States
abstract class UserState {}

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateSuccess extends UserState {
  final UserModel user;
  UserStateSuccess({required this.user});
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStateInitial()) {
    on<UserCreateEvent>(
      (event, emit) {
        emit(UserStateLoading());
        try {
          FirebaseContants.usersCollection.doc(event.user.uid).set({
            'userId': event.user.uid,
            'createdAt': DateTime.now(),
            'updatedAt': DateTime.now(),
            'displayName': event.user.displayName,
            'email': event.user.email,
            'phoneNumber': event.user.phoneNumber,
            'photoUrl': event.user.photoURL,
          });
          emit(UserStateSuccess(user: event.user));
        } catch (e) {
          emit(UserStateInitial());
        }
      },
    );
    on<UserEventFetch>((event, emit) async {
      emit(UserStateLoading());
      try {
        final user = await FirebaseContants.usersCollection.doc(event.id).get();
        emit(UserStateSuccess(user: UserModel.fromJson(user.data()!)));
      } catch (e) {
        emit(UserStateInitial());
      }
    });
  }
}
