import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/screens/main-tabs/profile/widgets/profile_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String photoUrl;
  final String firstName;
  final String lastName;
  final String country;
  final String bio;
  const ProfileHeaderWidget({
    Key? key,
    required this.photoUrl,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.bio,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: context.height() * 0.20,
            width: context.width(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondaryColor,
                width: 1,
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(photoUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) => Icon(
                  Icons.account_circle_rounded,
                  size: 100,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            child: (photoUrl.isEmpty)
                ? const Icon(
                    Ionicons.person,
                    size: 50,
                  )
                : const SizedBox.shrink(),
          ).box.color(AppColors.appGreyColor).roundedFull.makeCentered(),
        ),
        20.widthBox,
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileTextWidget(
                text1: firstName,
                text2: lastName,
              ),
              5.heightBox,
              country.text
                  .size(16)
                  .fontFamily(AppFonts.openSansMedium)
                  .color(AppColors.appTextColorPrimary)
                  .make(),
              10.heightBox,
              bio.text
                  .fontFamily(AppFonts.openSansLight)
                  .maxLines(2)
                  .size(15)
                  .make(),
            ],
          ),
        ),
      ],
    ).box.make().wh(context.width(), context.height() * 0.20);
  }
}
