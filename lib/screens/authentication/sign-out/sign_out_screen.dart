import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/landing/splash_screen.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/secondary_button_widget.dart';
import 'package:cookbook/widgets/logo/logo_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SignOutScreen extends StatefulWidget {
  const SignOutScreen({Key? key}) : super(key: key);

  @override
  State<SignOutScreen> createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
  signOut() {
    FirebaseAuth.instance.signOut().then((_) async {
      AppDialogs.loadingDialog(context);
      Future.delayed(3.seconds, () {
        AppDialogs.closeLoadingDialog();
        AppNavigator.replaceTo(
          context: context,
          screen: const SplashScreen(),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: AppText.signOutText),
      body: PageWidget(
        children: [
          const LogoWidget(),
          20.heightBox,
          RichText(
            text: TextSpan(
              text: "Are you",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.openSansBold,
              ),
              children: [
                TextSpan(
                  text: " Sure?",
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.openSansBold,
                  ),
                ),
              ],
            ),
          ),
          20.heightBox,
          "Are you sure you want to sign out?"
              .text
              .size(20)
              .semiBold
              .make()
              .centered(),
          20.heightBox,
          SecondaryButtonWidget(
            caption: AppText.signOutText,
            onPressed: signOut,
          ),
        ],
      ),
    );
  }
}
