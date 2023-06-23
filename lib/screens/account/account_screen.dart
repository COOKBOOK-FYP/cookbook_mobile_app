import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/secondary_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppbarWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                SecondaryButtonWidget(
                  caption: "Log out",
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ).box.make().p20(),
          ],
        ),
      ),
    );
  }
}
