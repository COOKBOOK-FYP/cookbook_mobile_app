// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:cookbook/constants/app_theme.dart';
import 'package:cookbook/screens/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Cookbook',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              // home: BlocBuilder<SessionHandlingCubit, SessionHandlingState>(
              //   builder: (context, state) {
              //     if (state is SessionHandlingHomeScreen) {
              //       return MainTabsScreen();
              //     } else if (state is SessionHandlingLoginScreen) {
              //       return SignInScreen();
              //     } else if (state is SessionHandlingOnBoarding) {
              //       return OnboardingScreen();
              //     } else if (state is SessionHandlingFailed) {
              //       return ErrorScreen();
              //     } else {
              //       return SizedBox();
              //     }
              //   },
              // ),
              home: OnboardingScreen(),
            ),
          );
        });
  }
}
