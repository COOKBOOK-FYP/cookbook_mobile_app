import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/splash/splash_screen.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  logOut() {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.appBlackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: PrimaryButtonWidget(
            caption: "Log out",
            onPressed: () async {
              await logOut();
            }),
      ),
    );
  }
}
