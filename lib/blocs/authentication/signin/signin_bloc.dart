import 'dart:io';

import 'package:cookbook/constants/app_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

// Events
abstract class SigninEvent {}

class SigninWithCredentialsEvent extends SigninEvent {
  final String email;
  final String password;

  SigninWithCredentialsEvent(this.email, this.password);
}

// States
abstract class SigninState {}

class SigninStateInitial extends SigninState {}

class SigninStateLoading extends SigninState {}

class SigninStateSuccess extends SigninState {
  final UserCredential userCredential;
  SigninStateSuccess(this.userCredential);
}

class SigninStateFailed extends SigninState {
  final String message;
  SigninStateFailed({this.message = "Something went wrong"});
}
// Bloc

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninStateInitial()) {
    isNetworkAvailable().then((connectionState) {
      if (!connectionState) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(SigninStateFailed(message: "No Internet Connection"));
      } else {
        on<SigninWithCredentialsEvent>((event, emit) async {
          emit(SigninStateLoading());
          try {
            final userCred =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            emit(SigninStateSuccess(userCred));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'invalid-email') {
              emit(SigninStateFailed(message: AppText.invalidEmailText));
              // Handle the invalid email address error here
            } else if (e.code == 'wrong-password') {
              emit(SigninStateFailed(message: AppText.invalidPasswordText));
            } else if (e.code == 'user-not-found') {
              emit(SigninStateFailed(message: AppText.userNotFoundText));
            } else if (e.code == 'too-many-requests') {
              emit(SigninStateFailed(message: AppText.tooManyLoginsText));
            } else {
              emit(SigninStateFailed(
                message: "${AppText.unexpectedLoginErrorText}: ${e.message}",
              ));
            }
          } catch (error) {
            if (error is FirebaseException) {
              if (error.message!.contains('Failed host lookup')) {
                emit(SigninStateFailed(message: 'No internet connection'));
              }
            } else if (error is SocketException) {
              emit(SigninStateFailed(message: 'No internet connection'));
            } else if (error is HttpException) {
              emit(SigninStateFailed(message: 'No service found'));
            } else {
              emit(SigninStateFailed(message: error.toString()));
            }
          }
        });
      }
    });
  }
}
