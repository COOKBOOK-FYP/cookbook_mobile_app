import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class ProfileTextWidget extends StatelessWidget {
  final String text1, text2;
  const ProfileTextWidget({Key? key, required this.text1, required this.text2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
          color: AppColors.appTextColorPrimary,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.robotoMonoBold,
          // decoration: TextDecoration.underline,
        ),
        children: <TextSpan>[
          TextSpan(
            text: " $text2",
            style: TextStyle(
              color: AppColors.appTextColorPrimary,
              fontSize: 23,
              fontWeight: FontWeight.normal,
              fontFamily: AppFonts.robotoLight,
              // decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
