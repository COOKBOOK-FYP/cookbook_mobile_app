// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:cookbook/blocs/Users/user_bloc.dart';
import 'package:cookbook/blocs/session_handling/splash_cubit.dart';
import 'package:cookbook/constants/app_theme.dart';
import 'package:cookbook/constants/bloc_provider.dart';
import 'package:cookbook/models/User/user.dart';
import 'package:cookbook/screens/authentication/splash/splash_screen.dart';
import 'package:cookbook/screens/error/error_screen.dart';
import 'package:cookbook/screens/main-tabs-screen/main_tabs_screen.dart';
import 'package:cookbook/screens/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Phoenix(child: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(context.width(), context.height()),
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              hideKeyboard(context);
            },
            child: MultiBlocProvider(
              providers: BlocProviders.providers,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Cookbook',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                home: BlocBuilder<SessionHandlingCubit, SessionHandlingState>(
                  builder: (context, state) {
                    if (state is SessionHandlingHomeScreen) {
                      BlocProvider.of<UserBloc>(context).add(
                        UserCreateEvent(
                          user: UserModel(
                            displayName: state.user?.displayName.toString(),
                            email: state.user?.email.toString(),
                            // phoneNumber: state.user?.phoneNumber.toString(),
                            uid: state.user?.uid.toString(),
                            photoURL: state.user?.photoURL.toString(),
                          ),
                        ),
                      );
                      return MainTabsScreen();
                    } else if (state is SessionHandlingLoginScreen) {
                      return SplashScreen();
                    } else if (state is SessionHandlingOnBoarding) {
                      return OnboardingScreen();
                    } else if (state is SessionHandlingFailed) {
                      return ErrorScreen();
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                // home: OnboardingScreen(),
              ),
            ),
          );
        });
  }
}
