import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/models/Notification/notification_model.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/screens/comments/comments_screen.dart';
import 'package:cookbook/widgets/images/circular_image.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:velocity_x/velocity_x.dart';

class PostWidget extends StatefulWidget {
  final RecipeModel post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool? isPostLiked = false;
  var bloc = UserCollectionBloc();

  @override
  void initState() {
    bloc = bloc..add(UserCollectionGetDataEvent(widget.post.ownerId));
    setState(() {
      isPostLiked =
          widget.post.likes?[FirebaseAuth.instance.currentUser!.uid] ?? false;
    });
    super.initState();
  }

  Future<void> likePost() async {
    try {
      if (isPostLiked == true) {
        widget.post.likes?.remove(FirebaseAuth.instance.currentUser!.uid);
        widget.post.likeCount = widget.post.likeCount! - 1;
        isPostLiked = false;
        FirebaseContants.usersCollection.doc(widget.post.ownerId).update({
          'like': FieldValue.increment(-1),
        });

        FirebaseFirestore.instance
            .collection("FeedPosts")
            .doc(widget.post.postId)
            .update({
          'likes': widget.post.likes,
          'likeCount': FieldValue.increment(-1),
        });
        await removeLikeFromNotification();
      } else {
        widget.post.likes?[FirebaseAuth.instance.currentUser!.uid] = true;
        widget.post.likeCount = widget.post.likeCount! + 1;
        isPostLiked = true;
        // increment likes in the user collection
        FirebaseContants.usersCollection.doc(widget.post.ownerId).update({
          'likes': FieldValue.increment(1),
        });
        FirebaseFirestore.instance
            .collection("FeedPosts")
            .doc(widget.post.postId)
            .update({
          'likes': widget.post.likes,
          'likeCount': FieldValue.increment(1),
        });
        await addLikeToNotification();
      }
      await FirebaseContants.recipesCollection
          .doc(widget.post.ownerId)
          .collection('UserPosts')
          .doc(widget.post.postId)
          .update({
        'likes': widget.post.likes,
        'likeCount': widget.post.likeCount,
      });

      await FirebaseFirestore.instance
          .collection("FeedPosts")
          .doc(widget.post.postId!)
          .update({
        'likes': widget.post.likes,
        'likeCount': widget.post.likeCount,
      });
      setState(() {});
    } catch (error) {
      AppSnackbars.danger(context, error.toString());
    }
  }

  Future<void> addLikeToNotification() async {
    if (widget.post.ownerId == FirebaseAuth.instance.currentUser!.uid) return;
    await FirebaseContants.feedCollection
        .doc(widget.post.ownerId)
        .collection("notifications")
        .doc(widget.post.postId)
        .set(NotificationModel(
          type: "like",
          userId: FirebaseAuth.instance.currentUser!.uid,
          mediaUrl: widget.post.image.toString(),
          postId: widget.post.postId,
          createdAt: Timestamp.now(),
        ).toJson());
  }

  Future<void> removeLikeFromNotification() async {
    if (widget.post.ownerId == FirebaseAuth.instance.currentUser!.uid) return;
    final doc = await FirebaseContants.feedCollection
        .doc(widget.post.ownerId)
        .collection("notifications")
        .doc(widget.post.postId)
        .get();

    if (doc.exists) {
      doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is UserCollectionLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to user profile screen with user id
                      print(state.userDocument.userId);
                    },
                    child: CircularImage(
                      imageUrl: state.userDocument.photoUrl.toString(),
                    ),
                  ),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.userDocument.fullName
                          .toString()
                          .text
                          .fontFamily(AppFonts.robotoMonoBold)
                          .size(16)
                          .make(),
                      // just now, 2 min ago, 1 day ago
                      "${widget.post.category} - ${timeago.format(widget.post.createdAt!.toDate())}"
                          .text
                          .make(),
                    ],
                  ),
                  // const Spacer(),
                  // Icon(
                  //   Ionicons.trash,
                  //   size: 20.sp,
                  //   color: Colors.red,
                  // ),
                ],
              ),
              10.heightBox,
              // image description with auto resize text
              widget.post.description.toString().text.make(),
              10.heightBox,
              GestureDetector(
                onTap: () {},
                onDoubleTap: () async {
                  if (isPostLiked == false) {
                    AppDialogs.postLikeDialog(context);
                    await likePost();
                    AppDialogs.closeDialog();
                    setState(() {});
                  } else {
                    await likePost();
                    setState(() {});
                  }
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
                      ? "${widget.post.likeCount}".text.make()
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
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      AppNavigator.goToPage(
                        context: context,
                        screen: CommentsScreen(post: widget.post),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Ionicons.chatbox_outline, size: 20.sp),
                        5.widthBox,
                        "Comments".text.semiBold.make(),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1),
            ],
          );
        }
        return const LoadingWidget().box.make().centered();
      },
    );
  }
}
