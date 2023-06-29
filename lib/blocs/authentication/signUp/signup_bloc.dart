// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/controllers/Auth/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

// Events
abstract class SignupEvent {}

class SignupWithCredentialsEvent extends SignupEvent {
  final String email, password, firstName, lastName;
  final String phoneNumber;
  SignupWithCredentialsEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}

// States
abstract class SignupState {}

class SignupStateInitial extends SignupState {}

class SignupStateLoading extends SignupState {}

class SignupStateSuccess extends SignupState {}

class SignupStateFailed extends SignupState {
  final String message;
  SignupStateFailed({this.message = "Something went wrong"});
}
// Bloc

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupStateInitial()) {
    isNetworkAvailable().then((connectionState) {
      if (!connectionState) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(SignupStateFailed(message: "No Internet Connection"));
      } else {
        on<SignupWithCredentialsEvent>((event, emit) async {
          emit(SignupStateLoading());
          try {
            final userCred =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            await AuthController.createUser(
              userCred.user!.uid,
              email: event.email,
              firstName: event.firstName,
              lastName: event.lastName,
              fullName: '${event.firstName} ${event.lastName}',
              phoneNumber: event.phoneNumber,
            );
            emit(SignupStateSuccess());
          } on FirebaseAuthException catch (e) {
            if (e.code == 'invalid-email') {
              emit(SignupStateFailed(message: AppText.invalidEmailText));
            } else if (e.code == 'email-already-in-use') {
              emit(SignupStateFailed(message: AppText.emailIsAlreadyInUseText));
            } else if (e.code == 'weak-password') {
              emit(SignupStateFailed(message: AppText.weakPasswordText));
            } else {
              emit(SignupStateFailed(
                message: '${AppText.unexpectedLoginErrorText}: ${e.message}',
              ));
            }
          } catch (error) {
            if (error is FirebaseException) {
              if (error.message!.contains('Failed host lookup')) {
                emit(SignupStateFailed(message: 'No internet connection'));
              }
            } else if (error is SocketException) {
              emit(SignupStateFailed(message: 'No internet connection'));
            } else if (error is HttpException) {
              emit(SignupStateFailed(message: 'No service found'));
            } else {
              emit(SignupStateFailed(message: error.toString()));
            }
          }
        });
      }
    });
  }
}
