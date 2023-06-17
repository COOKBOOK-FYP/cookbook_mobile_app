import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget(
      {Key? key, required this.text, required this.onPressed, this.textColor})
      : super(key: key);
  final String text;
  final Function onPressed;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: text.text.color(textColor ?? AppColors.primaryColor).make(),
      onPressed: () {
        onPressed();
      },
    );
  }
}
