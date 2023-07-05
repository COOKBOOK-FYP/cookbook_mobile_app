import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircularImage(
              imageUrl: "https://picsum.photos/200/300",
            ),
            10.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Wasim Zaman"
                    .text
                    .fontFamily(AppFonts.robotoMonoBold)
                    .size(16)
                    .make(),
                "Category - 4h".text.make(),
              ],
            ),
            const Spacer(),
            Icon(
              Ionicons.ellipsis_horizontal_outline,
              size: 20.sp,
            ),
          ],
        ),
        10.heightBox,
        // image description with auto resize text
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget ultricies aliquam, nisl nisl ultricies"
            .text
            .make(),
        10.heightBox,
        Container(
          height: 200.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://picsum.photos/200/300"),
              fit: BoxFit.cover,
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
            "100".text.make(),
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
