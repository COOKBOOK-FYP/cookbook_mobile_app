import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Four0FourScreen extends StatelessWidget {
  const Four0FourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWidget(children: [
      Lottie.asset(LottieAssets.error),
    ]);
  }
}
