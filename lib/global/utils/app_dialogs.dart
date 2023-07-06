import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppDialogs {
  static BuildContext? dialogueContext;
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogueContext = ctx;
        return Container(
          color: AppColors.transparentColor,
          child: Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 30.0,
            ),
          ),
        );
      },
    );
  }

  static void closeLoadingDialog() {
    Navigator.pop(dialogueContext!);
  }

  static void exitDialog() {
    showDialog(
      context: dialogueContext!,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(dialogueContext!);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
