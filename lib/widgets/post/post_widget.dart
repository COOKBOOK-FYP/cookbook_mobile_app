import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/constants/firebase_constants.dart';
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
      isPostLiked =
          widget.post.likes?[FirebaseAuth.instance.currentUser!.uid] ?? false;
    });
    super.initState();
  }

  Future<void> likePost() async {
    if (isPostLiked == true) {
      widget.post.likes?.remove(FirebaseAuth.instance.currentUser!.uid);
      widget.post.likeCount = widget.post.likeCount! - 1;
      isPostLiked = false;
    } else {
      widget.post.likes?[FirebaseAuth.instance.currentUser!.uid] = true;
      widget.post.likeCount = widget.post.likeCount! + 1;
      isPostLiked = true;
    }
    await FirebaseContants.recipesCollection
        .doc(widget.post.ownerId)
        .collection('UserPosts')
        .doc(widget.post.postId)
        .update({'likes': widget.post.likes});

    FirebaseContants.recipesCollection
        .doc(widget.post.ownerId)
        .collection('UserPosts')
        .doc(widget.post.postId)
        .update({'likeCount': widget.post.likeCount});
    setState(() {});
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
            Icon(
              Ionicons.trash,
              size: 20.sp,
              color: Colors.red,
            ),
          ],
        ),
        10.heightBox,
        // image description with auto resize text
        widget.post.description.toString().text.make(),
        10.heightBox,
        GestureDetector(
          onDoubleTap: () async {
            AppDialogs.postLikeDialog(context);
            await likePost();
            AppDialogs.closeDialog();
          },
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.post.image.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  likePost();
                });
              },
              icon: isPostLiked == true
                  ? Lottie.asset(
                      LottieAssets.doubleTapLike2,
                      repeat: false,
                    )
                  : Icon(
                      isPostLiked == true
                          ? Ionicons.heart
                          : Ionicons.heart_outline,
                      color: Colors.lightBlue,
                      size: 25.sp,
                    ),
            ),

            isPostLiked == true
                ? "You and other ${widget.post.likeCount}".text.make()
                : widget.post.likeCount.toString().text.make(),
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
        const Divider(thickness: 1),
      ],
    );
  }
}
