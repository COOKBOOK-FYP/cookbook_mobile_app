import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/splash/splash_screen.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
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
    return const Scaffold(
      appBar: SecondaryAppbarWidget(title: AppText.signOutText),
      body: PageWidget(
        children: [],
      ),
    );
  }
}
