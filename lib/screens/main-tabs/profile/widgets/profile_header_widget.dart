import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/screens/main-tabs/profile/widgets/profile_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileHeaderWidget extends StatefulWidget {
  final String photoUrl;
  final String firstName;
  final String lastName;
  final String country;
  final String bio;
  final int likes, postCount;
  const ProfileHeaderWidget({
    Key? key,
    required this.photoUrl,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.bio,
    required this.likes,
    required this.postCount,
  }) : super(key: key);

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  getPostCount() {
    int count = 0;
    FirebaseContants.recipesCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('UserPosts')
        .get()
        .then((value) {
      count = value.size;
      print(count);
    });
  }

  @override
  void initState() {
    getPostCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                    image: CachedNetworkImageProvider(widget.photoUrl),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) => Icon(
                      Icons.account_circle_rounded,
                      size: 100,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                child: (widget.photoUrl.isEmpty)
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
                    text1: widget.firstName,
                    text2: widget.lastName,
                  ),
                  5.heightBox,
                  widget.country.text
                      .size(16)
                      .fontFamily(AppFonts.openSansMedium)
                      .color(AppColors.appTextColorPrimary)
                      .make(),
                  10.heightBox,
                  widget.bio.text
                      .fontFamily(AppFonts.openSansLight)
                      .maxLines(2)
                      .size(15)
                      .make(),
                ],
              ),
            ),
          ],
        ).box.make().wh(context.width(), context.height() * 0.20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     'Recipes: $postCount'.text.size(20.sp).make(),
        //     "Likes: $likes".text.size(20.sp).make(),
        //   ],
        // ),
      ],
    );
  }
}
