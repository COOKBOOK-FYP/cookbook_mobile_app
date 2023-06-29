import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String photoUrl;
  final double? radius;
  final Color? backgroundColor;
  final Color? iconColor;
  const CircleAvatarWidget({
    Key? key,
    required this.photoUrl,
    this.radius,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 30.0,
      backgroundColor: backgroundColor ?? AppColors.appGreyColor,
      backgroundImage: CachedNetworkImageProvider(photoUrl),
      onBackgroundImageError: (exception, stackTrace) =>
          const Icon(Ionicons.person_outline),
      child: photoUrl.isEmpty
          ? Icon(
              Ionicons.person_outline,
              color: iconColor ?? AppColors.appBlackColor,
            )
          : null,
    );
  }
}
