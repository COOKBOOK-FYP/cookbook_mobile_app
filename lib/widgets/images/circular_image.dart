import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class CircularImage extends StatelessWidget {
  final String imageUrl;
  final Color? borderColor;
  final VoidCallback? onTap;

  const CircularImage({
    Key? key,
    required this.imageUrl,
    this.borderColor,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 50.w,
        height: 50.w,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? AppColors.primaryColor,
            width: 2,
          ),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              imageUrl,
              errorListener: () => Icon(
                Ionicons.person,
                color: AppColors.primaryColor,
              ),
            ),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) => Icon(
              Ionicons.person,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        child: imageUrl.isEmptyOrNull
            ? const Icon(Ionicons.person)
            : const SizedBox.shrink(),
      ),
    );
  }
}
