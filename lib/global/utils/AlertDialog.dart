// ignore_for_file: sort_child_properties_last, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';

AlertDialog confirmAlertDialog(context, String title, String content,
    {Function()? YesPressed, Function()? NoPressed, String? yes, String? no}) {
  return AlertDialog(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Text(title, style: boldTextStyle(color: AppColors.primaryColor)),
    content: Text(
      content,
      style: secondaryTextStyle(color: Colors.black),
    ),
    actions: [
      TextButton(
        child: Text(
          yes ?? "Yes",
          style: primaryTextStyle(color: AppColors.primaryColor),
        ),
        onPressed: YesPressed,
      ),
      TextButton(
        child: Text(no ?? "No",
            style: primaryTextStyle(color: AppColors.primaryColor)),
        onPressed: NoPressed,
      ),
    ],
  );
}

void ShowLoadingDialog(context, {Color? back, Color? spinner}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Container(
      color: back,
      child: Center(
        child: SpinKitThreeBounce(
          color: AppColors.primaryColor,
          size: 30.0,
        ),
      ),
    ),
  );
}

void ShowErrorDialog(BuildContext context, String title, content,
    {Color? back, Color? spinner, String? Ok}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(title,
                style: boldTextStyle(color: AppColors.primaryColor)),
            content: Text(
              content,
              style: secondaryTextStyle(
                  color: Theme.of(context).primaryColorLight),
            ),
            actions: [
              TextButton(
                child: Text(
                  Ok ?? "Ok",
                  style: primaryTextStyle(color: AppColors.primaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

Future ShowDialogAutoDismiss(BuildContext context, Timer? _timer,
    {Function()? aftermethod}) async {
  await showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        _timer = Timer(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });

        return SpinKitThreeBounce(
          color: AppColors.primaryColor,
          size: 30.0,
        );
      }).then((val) {
    aftermethod;
    if (_timer!.isActive) {
      _timer!.cancel();
    }
  });
}

void DismissLoadingDialog(context) {
  Navigator.of(context).pop();
}
