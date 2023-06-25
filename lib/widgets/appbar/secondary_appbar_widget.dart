import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class SecondaryAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const SecondaryAppbarWidget({Key? key, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
          title: title.text.xl2.bold.make(),
          leading: IconButton(
            icon: Icon(
              Ionicons.arrow_back,
              color: AppColors.appBlackColor,
            ),
            onPressed: () {
              context.pop();
            },
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
