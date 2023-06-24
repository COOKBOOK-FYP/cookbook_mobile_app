import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RoundIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  const RoundIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: icon.box
          .margin(const EdgeInsets.only(right: 20))
          .padding(const EdgeInsets.all(3))
          .color(AppColors.appGreyColor.withOpacity(0.6))
          .roundedFull
          .make()
          .wh(55, 55),
    );
  }
}
