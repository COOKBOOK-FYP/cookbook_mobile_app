// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
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
