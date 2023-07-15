import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class ErrorScreen extends StatelessWidget {
  final String lottie;
  final String message;
  final String? buttonText;
  final VoidCallback onPressed;
  const ErrorScreen({
    Key? key,
    required this.lottie,
    required this.message,
    this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(LottieAssets.noPosts),
        message.text
            .maxLines(2)
            .size(20.sp)
            .center
            .fontFamily(AppFonts.openSansBold)
            .makeCentered(),
        20.heightBox,
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: buttonText?.text.center
                .color(AppColors.primaryColor)
                .size(20.sp)
                .fontFamily(AppFonts.robotoMonoMedium)
                .make()
                .py12(),
          ).box.roundedFull.make(),
        ),
      ],
    ).box.make().p20();
  }
}
