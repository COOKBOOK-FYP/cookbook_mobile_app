import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:flutter/material.dart';

class SecondaryButtonWidget extends StatelessWidget {
  const SecondaryButtonWidget(
      {Key? key, required this.caption, required this.onPressed})
      : super(key: key);
  final String caption;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      caption: caption,
      onPressed: onPressed,
      backgroundColor: AppColors.secondaryColor,
    );
  }
}
