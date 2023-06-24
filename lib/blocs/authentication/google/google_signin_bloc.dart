import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/controllers/Auth/auth_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class GoogleSigninEvent {}

class GoogleSigninButtonPressedEvent extends GoogleSigninEvent {}

// States
abstract class GoogleSigninState {}

class GoogleSigninInitial extends GoogleSigninState {}

class GoogleSigninLoading extends GoogleSigninState {}

class GoogleSigninSuccess extends GoogleSigninState {}

class GoogleSigninFailed extends GoogleSigninState {
  final String errorMessage;

  GoogleSigninFailed(this.errorMessage);
}

class GoogleSigninBloc extends Bloc<GoogleSigninEvent, GoogleSigninState> {
  GoogleSigninBloc() : super(GoogleSigninInitial()) {
    on<GoogleSigninEvent>((event, emit) async {
      if (event is GoogleSigninButtonPressedEvent) {
        emit(GoogleSigninLoading());
        try {
          final account = await FirebaseContants.googleSignIn.signIn();

          await AuthController.createUser(
            account!.id,
            email: account.email,
            displayName: account.displayName,
            photoUrl: account.photoUrl,
          );
        } catch (error) {
          emit(GoogleSigninFailed(error.toString()));
        }
        emit(GoogleSigninSuccess());
      }
    });
  }
}
