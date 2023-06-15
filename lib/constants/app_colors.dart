// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

abstract class AppColors {
  static var iconbackgroundColor = Color.fromARGB(255, 251, 221, 186);

  static var primaryColor = Color.fromRGBO(255, 0, 0, 1);
  static var secondaryColor = Color.fromRGBO(0, 128, 0, 1);
  static var backgroundColor = Colors.grey[50];
  static var dangerColor = Color(0xFFA52A2A);
  static var successColor = Color(0xFF155724);
  static var transparentColor = Colors.transparent;

  static var appTextColorPrimary = Color(0xFF212121);
  static var appTextColorSecondary = Color(0xFF5A5C5E);

  static var appWhiteColor = Colors.white;
  static var appBlackColor = Colors.black;
  static var appGreyColor = Colors.grey.shade300;
  static var appRedColor = Colors.red;
}
