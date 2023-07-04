import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class AvatarImageWidget extends StatelessWidget {
  const AvatarImageWidget({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.boxFit,
  }) : super(key: key);
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Container(
      // make it circle
      height: height ?? 100.h,
      width: width ?? 100.w,
      padding: EdgeInsets.all(5.0.w),
      decoration: BoxDecoration(
        color: AppColors.appGreyColor.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.appGreyColor.withOpacity(0.2),
          width: 2.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: CachedNetworkImage(
          fit: boxFit ?? BoxFit.fill,
          imageUrl: imageUrl,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(
            Ionicons.person_outline,
            size: 40.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
