import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaterialButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? iconBgColor;
  final double? size;
  const MaterialButtonWidget({
    Key? key,
    this.onPressed,
    required this.icon,
    this.iconBgColor,
    this.size,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed ?? () {},
      color: iconBgColor ?? AppColors.iconbackgroundColor,
      splashColor: AppColors.secondaryColor,
      textColor: AppColors.appWhiteColor,
      padding: EdgeInsets.all(5.w),
      shape: const CircleBorder(),
      child: Icon(
        icon,
        size: size ?? 20.sp,
        color: AppColors.backgroundColor,
      ),
    );
  }
}
