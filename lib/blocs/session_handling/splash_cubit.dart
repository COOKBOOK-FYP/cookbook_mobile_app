// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cookbook/constants/google_constants.dart';
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
        String? userToken = await UserSecureStorage.fetchToken();
        String? userId = await UserSecureStorage.fetchUserId();
        String? newUser = await UserSecureStorage.fetchNewUser();

        GoogleConstants.googleSignIn.onCurrentUserChanged.listen((account) {
          if (account != null) {
            emit(SessionHandlingHomeScreen());
          } else {
            emit(SessionHandlingLoginScreen());
          }
        }, onError: (error) {
          emit(SessionHandlingFailed());
        });

        GoogleConstants.googleSignIn.signInSilently(suppressErrors: false).then(
            (account) {
          if (account != null) {
            emit(SessionHandlingHomeScreen());
          } else {
            emit(SessionHandlingLoginScreen());
          }
        }, onError: (error) {
          emit(SessionHandlingFailed());
        });

        if (userToken != null && userId != null) {
          emit(SessionHandlingHomeScreen());
        } else if (userId == null && newUser != null) {
          emit(SessionHandlingLoginScreen());
        } else {
          emit(SessionHandlingOnBoarding());
        }
      } else {
        emit(SessionHandlingFailed());
      }
    } catch (e) {
      emit(SessionHandlingFailed());
    }
  }
}
