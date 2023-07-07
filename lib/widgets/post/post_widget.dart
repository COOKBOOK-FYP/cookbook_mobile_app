import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class PostWidget extends StatelessWidget {
  final RecipeModel post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircularImage(
              imageUrl: post.ownerPhotoUrl.toString(),
            ),
            10.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                post.ownerName
                    .toString()
                    .text
                    .fontFamily(AppFonts.robotoMonoBold)
                    .size(16)
                    .make(),
                (DateTime.now().hour - post.createdAt!.toDate().hour) > 24
                    ? "${post.category} - ${(DateTime.now().hour - post.createdAt!.toDate().hour) ~/ 24} days ago"
                        .text
                        .make()
                    : "${post.category} - ${(DateTime.now().hour - post.createdAt!.toDate().hour)} hours ago"
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
        post.description.toString().text.make(),
        10.heightBox,
        AspectRatio(
          aspectRatio: 0.7,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage(post.image.toString()),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        10.heightBox,
        Row(
          children: [
            Icon(
              Ionicons.heart_outline,
              size: 30.sp,
            ),
            5.widthBox,
            post.likes.toString().text.make(),
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
