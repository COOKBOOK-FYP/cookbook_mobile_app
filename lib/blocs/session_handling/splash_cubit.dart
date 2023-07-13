// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cookbook/global/utils/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

        // FirebaseContants.googleSignIn.onCurrentUserChanged.listen((account) {
        //   if (account != null) {
        //     UserController.createUser(
        //       account.id,
        //       name: account.displayName,
        //       email: account.email,
        //       phoneNumber: "",
        //       photoUrl: account.photoUrl,
        //     );
        //     emit(SessionHandlingHomeScreen());
        //   } else {
        //     if (newUser != null) {
        //       emit(SessionHandlingLoginScreen());
        //     } else {
        //       emit(SessionHandlingOnBoarding());
        //     }
        //   }
        // }, onError: (error) {
        //   emit(SessionHandlingFailed());
        // });

        // FirebaseContants.googleSignIn
        //     .signInSilently(suppressErrors: false)
        //     .then((account) {
        //   if (account != null) {
        //     emit(SessionHandlingHomeScreen());
        //   } else {
        //     if (newUser != null) {
        //       emit(SessionHandlingLoginScreen());
        //     } else {
        //       emit(SessionHandlingOnBoarding());
        //     }
        //   }
        // }, onError: (error) {
        //   emit(SessionHandlingLoginScreen());
        // });

// Sign in session handling //
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            if (newUser != null) {
              emit(SessionHandlingLoginScreen());
            } else {
              emit(SessionHandlingOnBoarding());
            }
          } else {
            emit(SessionHandlingHomeScreen(user: user));
          }
        });

        FirebaseAuth.instance.idTokenChanges().listen((User? user) {
          if (user == null) {
            if (newUser != null) {
              emit(SessionHandlingLoginScreen());
            } else {
              emit(SessionHandlingOnBoarding());
            }
          } else {
            emit(SessionHandlingHomeScreen(user: user));
          }
        });

        FirebaseAuth.instance.userChanges().listen((User? user) {
          if (user == null) {
            if (newUser != null) {
              emit(SessionHandlingLoginScreen());
            } else {
              emit(SessionHandlingOnBoarding());
            }
          } else {
            emit(SessionHandlingHomeScreen(user: user));
          }
        });
      } else {
        emit(SessionHandlingNoInternet());
      }
    } catch (e) {
      emit(SessionHandlingFailed());
    }
  }
}
