// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/controllers/User/user_controller.dart';
import 'package:cookbook/global/utils/secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';

part 'splash_state.dart';

class SessionHandlingCubit extends Cubit<SessionHandlingState> {
  SessionHandlingCubit() : super(SessionHandlingInitial());

  initliazeRoute() async {
    try {
      bool connectionValue = await isNetworkAvailable();
      if (connectionValue) {
        String? newUser = await UserSecureStorage.fetchNewUser();
        String? userId = await UserSecureStorage.fetchUserId();

        FirebaseContants.googleSignIn.onCurrentUserChanged.listen((account) {
          if (account != null) {
            UserController.createUser(
              account.id,
              name: account.displayName,
              email: account.email,
              phoneNumber: "",
              photoUrl: account.photoUrl,
            );
            emit(SessionHandlingHomeScreen());
          } else {
            if (newUser != null) {
              emit(SessionHandlingLoginScreen());
            } else {
              emit(SessionHandlingOnBoarding());
            }
          }
        }, onError: (error) {
          emit(SessionHandlingFailed());
        });

        FirebaseContants.googleSignIn
            .signInSilently(suppressErrors: false)
            .then((account) {
          if (account != null) {
            emit(SessionHandlingHomeScreen());
          } else {
            if (newUser != null) {
              emit(SessionHandlingLoginScreen());
            } else {
              emit(SessionHandlingOnBoarding());
            }
          }
        }, onError: (error) {
          emit(SessionHandlingLoginScreen());
        });
      } else {
        emit(SessionHandlingFailed());
      }
    } catch (e) {
      emit(SessionHandlingFailed());
    }
  }
}
