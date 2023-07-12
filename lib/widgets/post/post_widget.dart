import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/format_timestamp.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/widgets/images/circular_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class PostWidget extends StatefulWidget {
  final RecipeModel post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool? isPostLiked = false;

  @override
  void initState() {
    setState(() {
      isPostLiked = widget.post.likes?[FirebaseAuth.instance.currentUser!.uid];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircularImage(
              imageUrl: widget.post.ownerPhotoUrl.toString(),
            ),
            10.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.post.ownerName
                    .toString()
                    .text
                    .fontFamily(AppFonts.robotoMonoBold)
                    .size(16)
                    .make(),
                // just now, 2 min ago, 1 day ago
                "${widget.post.category} - ${formatTimestamp(widget.post.createdAt!)}"
                    .text
                    .make(),
              ],
            ),
            const Spacer(),
            Icon(Ionicons.ellipsis_horizontal_outline, size: 20.sp),
          ],
        ),
        10.heightBox,
        // image description with auto resize text
        widget.post.description.toString().text.make(),
        10.heightBox,
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              isPostLiked = !isPostLiked!;

              if (isPostLiked == true) {
                AppDialogs.postLikeDialog(context);
                Future.delayed(const Duration(seconds: 1), () {
                  AppDialogs.closeDialog();
                });
              }
            });
          },
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.post.image.toString(),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        10.heightBox,
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isPostLiked = !isPostLiked!;
                });
              },
              icon: isPostLiked == true
                  ? Lottie.asset(
                      LottieAssets.like,
                      repeat: false,
                    )
                  : Icon(
                      isPostLiked == true
                          ? Ionicons.heart
                          : Ionicons.heart_outline,
                      color: Colors.pink,
                    ),
            ),
            5.widthBox,
            widget.post.likeCount.toString().text.make(),
            // 10.widthBox,
            // Icon(
            //   Ionicons.chatbubble_outline,
            //   size: 20.sp,
            // ),
            // 10.widthBox,
            // Icon(
            //   Ionicons.share_outline,
            //   size: 20.sp,
            // ),
            // const Spacer(),
            // Icon(
            //   Ionicons.bookmark_outline,
            //   size: 20.sp,
            // ),
          ],
        ),
        const Divider(thickness: 2),
      ],
    );
  }
}
