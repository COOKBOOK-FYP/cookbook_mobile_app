import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static var lightTheme = ThemeData(
    primarySwatch: Colors.red,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
      primary: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: AppColors.backgroundColor,
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
        statusBarColor: AppColors.transparentColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );

  static var darkTheme = ThemeData(
    primarySwatch: Colors.red,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.secondaryColor,
      primary: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.appBlackColor,
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
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );
}
