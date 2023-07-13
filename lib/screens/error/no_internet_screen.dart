import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onPressed;
  const NoInternetScreen({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Lottie.asset(LottieAssets.noInternet),
            "No Internet Connection"
                .text
                .maxLines(2)
                .fontFamily(AppFonts.openSansMedium)
                .xl2
                .make(),
            PrimaryButtonWidget(
              caption: "Retry",
              onPressed: onPressed,
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
