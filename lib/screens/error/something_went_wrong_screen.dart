import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class SomethingWentWrongScreen extends StatelessWidget {
  final VoidCallback onPressed;

  const SomethingWentWrongScreen({Key? key, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Lottie.asset(LottieAssets.error),
            "Something went wrong".text.xl2.make(),
            SizedBox(height: 20.h),
            PrimaryButtonWidget(
              caption: "Retry",
              onPressed: () {},
            ),
          ],
        )
            .box
            .padding(
              const EdgeInsets.all(20),
            )
            .make(),
      ),
    );
  }
}
