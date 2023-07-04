import 'package:flutter/material.dart';

abstract class AppColors {
  static var primaryColor = const Color.fromRGBO(255, 0, 0, 1);
  static var secondaryColor = const Color.fromRGBO(0, 128, 0, 1);
  static var backgroundColor = Colors.grey[50];
  static var dangerColor = const Color(0xFFA52A2A);
  static var successColor = const Color(0xFF155724);
  static var transparentColor = Colors.transparent;

  static var appTextColorPrimary = const Color(0xFF212121);
  static var appTextColorSecondary = const Color(0xFF5A5C5E);

  static var appWhiteColor = Colors.white;
  static var appBlackColor = Colors.black;
  static var appGreyColor = Colors.grey.shade300;
  static var appDarkGreyColor = Colors.grey.shade800;
  static var appRedColor = Colors.red;

  static var iconbackgroundColor = const Color.fromARGB(255, 255, 94, 94);
}
