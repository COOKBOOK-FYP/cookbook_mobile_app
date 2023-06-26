import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:cookbook/widgets/logo/logo_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);
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
          "Account once deleted cannot be recovered. We delete all your data from out servers"
              .text
              .center
              .make(),
          20.heightBox,
          PrimaryButtonWidget(
            caption: AppText.deleteAccountText,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
