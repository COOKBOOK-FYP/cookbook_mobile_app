import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/sign-in/signin_screen.dart';
import 'package:cookbook/screens/authentication/sign-up/signup_screen.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:cookbook/widgets/buttons/secondary_button_widget.dart';
import 'package:cookbook/widgets/logo/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const LogoWidget(),
            20.heightBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Cook",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.openSansLight,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: "book",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.robotoLight,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            20.heightBox,
            AppText.appSplashDescription.text.center.makeCentered(),
            40.heightBox,
            PrimaryButtonWidget(
              caption: AppText.signinText,
              onPressed: () {
                AppNavigator.goToPage(
                  context: context,
                  screen: const SignInScreen(),
                );
              },
            ),
            20.heightBox,
            SecondaryButtonWidget(
              caption: AppText.createNewAccountText,
              onPressed: () {
                AppNavigator.goToPage(
                  context: context,
                  screen: const SignUpScreen(),
                );
              },
            ),
            context.isPortrait ? 80.heightBox : 10.heightBox,
          ],
        ).box.margin(const EdgeInsets.all(20)).make(),
      ),
    );
  }
}
