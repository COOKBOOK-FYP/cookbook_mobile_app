import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/main-tabs-screen/main_tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupCompletedScreen extends StatefulWidget {
  const SignupCompletedScreen({Key? key}) : super(key: key);

  @override
  State<SignupCompletedScreen> createState() => _SignupCompletedScreenState();
}

class _SignupCompletedScreenState extends State<SignupCompletedScreen> {
  @override
  void initState() {
    Future.delayed(5.seconds, () {
      AppNavigator.replaceTo(
        context: context,
        screen: const MainTabsScreen(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        LottieAssets.accountCreated,
        repeat: false,
      ).box.makeCentered(),
    );
  }
}
