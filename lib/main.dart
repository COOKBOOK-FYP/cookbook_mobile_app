// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/blocs/session_handling/splash_cubit.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/controllers/PushNotification/push_notification_controller.dart';
import 'package:cookbook/global/themes/app_theme.dart';
import 'package:cookbook/providers/bloc_provider.dart';
import 'package:cookbook/screens/authentication/landing/splash_screen.dart';
import 'package:cookbook/screens/error/no_internet_screen.dart';
import 'package:cookbook/screens/error/something_went_wrong_screen.dart';
import 'package:cookbook/screens/main-tabs/main_tabs_screen.dart';
import 'package:cookbook/screens/onboarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseApi().initNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Phoenix(child: MyApp()),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  @override
  void initState() {
    // PushNotificationController.requestPermissions();
    // PushNotificationController.getFCMToken().then((value) {
    //   FirebaseContants.fcmToken = value;
    // });

    PushNotificationController.getFcmToken().then((value) => print(value));

    token = PushNotificationController.refreshToken();
    if (token != null) {
      // update firebase collection
      FirebaseContants.fcmToken = token;
      FirebaseContants.pushNotificationColletion
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'fcmToken': token,
        'updatedAt': Timestamp.now(),
      });
    }

    // listen for the incoming messages
    PushNotificationController.listenMessages(context);
    // Handle background and terminated state payloads
    PushNotificationController.handlePayloadForTerminatedAndBackground(context);

    super.initState();
  }

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
                // darkTheme: AppTheme.darkTheme,
                // themeMode: ThemeMode.system,
                home: BlocBuilder<SessionHandlingCubit, SessionHandlingState>(
                  builder: (context, state) {
                    if (state is SessionHandlingHomeScreen) {
                      return MainTabsScreen();
                    } else if (state is SessionHandlingLoginScreen) {
                      return SplashScreen();
                    } else if (state is SessionHandlingOnBoarding) {
                      return OnboardingScreen();
                    } else if (state is SessionHandlingNoInternet) {
                      return NoInternetScreen(
                        onPressed: () {
                          context.read<SessionHandlingCubit>().initliazeRoute();
                        },
                      );
                    } else if (state is SessionHandlingFailed) {
                      return SomethingWentWrongScreen(
                        onPressed: () {
                          context.read<SessionHandlingCubit>().initliazeRoute();
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),
          );
        });
  }
}
