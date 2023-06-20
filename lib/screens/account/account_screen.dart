import 'package:cookbook/constants/google_constants.dart';
import 'package:cookbook/widgets/buttons/secondary_button_widget.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                SecondaryButtonWidget(
                  caption: "Log out",
                  onPressed: () {
                    GoogleConstants.googleSignIn.signOut();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
