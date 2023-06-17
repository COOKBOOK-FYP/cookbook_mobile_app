import 'package:cookbook/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class SecondaryTextWidget extends StatelessWidget {
  const SecondaryTextWidget(
      {Key? key,
      required this.text,
      this.fontSize,
      this.fontFamily,
      this.fontColor})
      : super(key: key);
  final String text;
  final double? fontSize;
  final String? fontFamily;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily ?? AppFonts.openSansLight,
        color: fontColor ?? Colors.black,
      ),
    );
  }
}
