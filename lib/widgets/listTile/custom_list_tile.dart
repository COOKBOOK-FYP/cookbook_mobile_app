import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback onTap;
  final Color? leadingIconBackgroundColor;
  final Color? leadingIconForegroundColor;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    this.leadingIconBackgroundColor,
    this.leadingIconForegroundColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            leadingIconBackgroundColor ?? AppColors.iconbackgroundColor,
        child: Icon(
          leadingIcon,
          color: leadingIconForegroundColor ?? AppColors.backgroundColor,
          size: 25,
        ),
      ),
      title: title.text.xl2.make(),
      trailing: Icon(
        Ionicons.chevron_forward_outline,
        color: AppColors.appDarkGreyColor,
        size: 25,
      ),
      onTap: onTap,
    );
  }
}
