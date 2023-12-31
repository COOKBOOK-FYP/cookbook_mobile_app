import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/complete_profile/complete_profile_screen.dart';
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
        screen: const CompleteProfileScreen(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            LottieAssets.accountCreated,
            repeat: false,
          ),
          "Account".text.xl2.bold.color(AppColors.primaryColor).make(),
          "Created".text.xl2.bold.color(AppColors.secondaryColor).make(),
          20.heightBox,
          "Your account has been created successfully.".text.center.xl.make(),
        ],
      ).box.p20.makeCentered(),
    );
  }
}
