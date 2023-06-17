import 'package:cookbook/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.3,
      child: Image.asset(AppImages.logo),
    ).animatedBox.make().centered();
  }
}
