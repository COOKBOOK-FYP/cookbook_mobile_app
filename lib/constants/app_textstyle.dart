import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_fonts.dart';

class AppTextStyle {
  static var onboardingTitleTextStyle = TextStyle(
    fontSize: 32,
    color: AppColors.appWhiteColor,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.robotoBold,
  );
  static var tabsTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.robotoBold,
  );

  static var topCategoriesStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.robotoBold,
  );
}
