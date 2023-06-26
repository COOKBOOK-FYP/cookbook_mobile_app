import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/screens/authentication/splash/splash_screen.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:cookbook/widgets/logo/logo_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  deleteAccount() {
    FirebaseAuth.instance.currentUser!.delete().then((account) {
      FirebaseAuth.instance.signOut().then((_) async {
        AppDialogs.loadingDialog(context);
        Future.delayed(3.seconds, () {
          AppDialogs.closeLoadingDialog();
          AppNavigator.replaceTo(
            context: context,
            screen: const SplashScreen(),
          );
        });
      }).catchError((error) {
        AppSnackbars.danger(context, error.toString());
      });
    }).catchError((error) {
      AppSnackbars.danger(context, error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: AppText.deleteAccountText),
      body: PageWidget(
        children: [
          const LogoWidget(),
          RichText(
            text: TextSpan(
              text: "GOOD",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.robotoMonoBold,
              ),
              children: [
                TextSpan(
                  text: "BYE",
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
          AppText.accountDeleteDescriptionText.text.center.make(),
          20.heightBox,
          PrimaryButtonWidget(
            caption: AppText.deleteAccountText,
            onPressed: deleteAccount,
          ),
        ],
      ),
    );
  }
}
