import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static var lightTheme = ThemeData(
    // primarySwatch: Colors.red,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
      primary: AppColors.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: AppColors.appWhiteColor,
      actionsIconTheme: IconThemeData(
        color: AppColors.appBlackColor,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.appBlackColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.robotoMonoRegular,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.appBlackColor,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );

  static var darkTheme = ThemeData(
    primarySwatch: Colors.red,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
      primary: AppColors.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: AppColors.appBlackColor,
      titleTextStyle: TextStyle(
        color: AppColors.appWhiteColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: AppFonts.robotoMonoRegular,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
      ),
    ),
  );
}
