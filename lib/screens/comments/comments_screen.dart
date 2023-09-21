import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/blocs/comments/comments_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/models/Comments/comment_model.dart';
import 'package:cookbook/models/Notification/notification_model.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/models/User/user_model.dart';
import 'package:cookbook/screens/comments/widgets/comment_widget.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentsScreen extends StatefulWidget {
  final RecipeModel post;
  const CommentsScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final commentsController = TextEditingController();
  CommentsBloc commentsBloc = CommentsBloc();
  UserCollectionBloc userCollectionBloc = UserCollectionBloc();
  List<CommentModel> comments = [];
  UserModel? user;

  @override
  void initState() {
    commentsBloc = commentsBloc
      ..add(
        CommentsGetDataEvent(postId: widget.post.postId!),
      );

    super.initState();
  }

  addCommentToNotification() async {
    if (FirebaseAuth.instance.currentUser!.uid != widget.post.ownerId!) {
      await FirebaseContants.feedCollection
          .doc(widget.post.ownerId!)
          .collection("notifications")
          .add(
            NotificationModel(
              type: "comment",
              createdAt: Timestamp.now(),
              postId: widget.post.postId,
              userId: FirebaseAuth.instance.currentUser!.uid,
              commentData: commentsController.text.trim(),
              mediaUrl: widget.post.image,
            ).toJson(),
          );
    } else {
      return;
    }
  }

  @override
  void dispose() {
    commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        commentsBloc.add(
          CommentsGetDataEvent(postId: widget.post.postId!),
        );
      },
      child: Scaffold(
        appBar: const SecondaryAppbarWidget(title: AppText.commentsText),
        body: BlocConsumer<CommentsBloc, CommentsState>(
          bloc: commentsBloc,
          listener: (context, state) {
            if (state is CommentsLoadingState) {
            } else if (state is CommentsAddedState) {
              AppSnackbars.normal(context, "Comment added successfully");
              commentsBloc.add(
                CommentsGetDataEvent(postId: widget.post.postId!),
              );
            } else if (state is CommentsNoInternetState) {
              AppSnackbars.normal(context, "No internet connection");
            }
          },
          builder: (context, state) {
            if (state is CommentsLoadingState) {
              return ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    Shimmer(
                      direction: const ShimmerDirection.fromLeftToRight(),
                      child: ListTile(
                        leading: Icon(
                          Ionicons.person,
                          size: 30,
                          color: AppColors.appDarkGreyColor,
                        ),
                        title: Shimmer(
                          direction: const ShimmerDirection.fromRBLT(),
                          child: Container(
                            height: 10,
                            width: 100,
                            color: AppColors.appGreyColor,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: AppColors.appDarkGreyColor),
                  ],
                ),
                itemCount: 5,
              );
            }
            if (state is CommentsEmptyState) {
              return Column(
                children: [
                  Expanded(
                    child: "No comments for this recipe yet!"
                        .text
                        .make()
                        .centered(),
                  ),
                  BlocListener<UserCollectionBloc, UserCollectionState>(
                    bloc: userCollectionBloc
                      ..add(UserCollectionGetDataEvent(null)),
                    listener: (context, state) {
                      if (state is UserCollectionLoadedState) {
                        user = state.userDocument;
                      }
                    },
                    child: ListTile(
                      title: TextField(
                        controller: commentsController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Add a comment",
                          border: InputBorder.none,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          if (commentsController.text.isNotEmpty) {
                            commentsBloc.add(
                              CommentsAddEvent(
                                comment: CommentModel(
                                  comment: commentsController.text,
                                  postId: widget.post.postId!,
                                  createdAt: Timestamp.now(),
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  username: user?.fullName,
                                ),
                                postId: widget.post.postId!,
                                postOwnerId: widget.post.ownerId!,
                              ),
                            );
                            await addCommentToNotification();
                            commentsController.clear();
                          }
                        },
                        icon: Icon(
                          Ionicons.send,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is CommentsLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CommentWidget(
                          userId: state.comments[index].userId.toString(),
                          comment: state.comments[index].comment.toString(),
                          createdAt: state.comments[index].createdAt,
                          username: state.comments[index].username.toString(),
                        );
                      },
                      itemCount: state.comments.length,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                  BlocListener<UserCollectionBloc, UserCollectionState>(
                    bloc: userCollectionBloc
                      ..add(UserCollectionGetDataEvent(null)),
                    listener: (context, state) {
                      if (state is UserCollectionLoadedState) {
                        user = state.userDocument;
                      }
                    },
                    child: ListTile(
                      title: TextField(
                        controller: commentsController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: AppText.addCommentText,
                          border: InputBorder.none,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          if (commentsController.text.isNotEmpty) {
                            commentsBloc.add(
                              CommentsAddEvent(
                                comment: CommentModel(
                                  comment: commentsController.text,
                                  postId: widget.post.postId!,
                                  createdAt: Timestamp.now(),
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  username: user?.fullName,
                                ),
                                postId: widget.post.postId!,
                                postOwnerId: widget.post.ownerId!,
                              ),
                            );
                            await addCommentToNotification();
                            commentsController.clear();
                          }
                        },
                        icon: Icon(
                          Ionicons.send,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
