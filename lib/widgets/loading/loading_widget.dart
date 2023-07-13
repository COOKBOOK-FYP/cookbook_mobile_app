import 'package:cookbook/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return SpinKitFadingCircle(
    //   color: AppColors.primaryColor,
    //   size: 50.0,
    // ).box.make().centered();
    return Lottie.asset(LottieAssets.loading)
        .box
        .size(150, 150)
        .make()
        .centered();
  }
}
