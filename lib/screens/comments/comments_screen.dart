import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/blocs/comments/comments_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/models/Comments/comment_model.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
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

  @override
  void initState() {
    commentsBloc = commentsBloc
      ..add(
        CommentsGetDataEvent(postId: widget.post.postId!),
      );

    super.initState();
  }

  @override
  void dispose() {
    commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: AppText.commentsText),
      body: BlocListener<CommentsBloc, CommentsState>(
        listener: (context, state) {
          if (state is CommentsLoadingState) {
            AppDialogs.loadingDialog(context);
          } else if (state is CommentsAddedState) {
            AppDialogs.closeDialog();
            commentsController.clear();
            AppSnackbars.normal(context, "Comment added successfully");
            commentsBloc.add(
              CommentsGetDataEvent(postId: widget.post.postId!),
            );
          } else if (state is CommentsNoInternetState) {
            AppDialogs.closeDialog();
            AppSnackbars.normal(context, "No internet connection");
          }
        },
        child: BlocBuilder<CommentsBloc, CommentsState>(
          bloc: commentsBloc,
          builder: (context, st) {
            if (st is CommentsLoadedState) {
              return Column(
                children: [
                  // AspectRatio(
                  //   aspectRatio: 1,
                  //   child: CachedNetworkImage(
                  //     imageUrl: post.image.toString(),
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        CommentModel comment = st.comments[index];
                        return BlocBuilder<UserCollectionBloc,
                            UserCollectionState>(
                          bloc: userCollectionBloc
                            ..add(UserCollectionGetDataEvent(
                                st.comments[index].userId)),
                          builder: (context, userState) {
                            if (userState is UserCollectionLoadedState) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    userState.userDocument.photoUrl.toString(),
                                  ),
                                  onBackgroundImageError:
                                      (exception, stackTrace) =>
                                          const Icon(Icons.error),
                                ),
                                title: Text(
                                  userState.userDocument.fullName.toString(),
                                ),
                                subtitle: "${comment.comment}"
                                    .text
                                    .size(16)
                                    .make()
                                    .pOnly(bottom: 8),
                                trailing: Text(
                                  DateFormat.yMMMd().format(
                                    comment.createdAt!.toDate(),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                      },
                      itemCount: st.comments.length,
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: commentsController,
                      decoration: const InputDecoration(
                        hintText: AppText.addCommentText,
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<CommentsBloc>().add(
                              CommentsAddEvent(
                                postId: widget.post.postId!,
                                comment: CommentModel(
                                  comment: commentsController.text.trim(),
                                  createdAt: Timestamp.now(),
                                  postId: widget.post.postId,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                ),
                              ),
                            );
                      },
                      icon: const Icon(Ionicons.send),
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                // AspectRatio(
                //   aspectRatio: 1,
                //   child: CachedNetworkImage(
                //     imageUrl: post.image.toString(),
                //     fit: BoxFit.contain,
                //   ),
                // ),
                Expanded(child: Container()),
                ListTile(
                  title: TextField(
                    controller: commentsController,
                    decoration: const InputDecoration(
                      hintText: AppText.addCommentText,
                      border: InputBorder.none,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<CommentsBloc>().add(
                            CommentsAddEvent(
                              postId: widget.post.postId!,
                              comment: CommentModel(
                                comment: commentsController.text.trim(),
                                createdAt: Timestamp.now(),
                                postId: widget.post.postId,
                                userId: widget.post.ownerId,
                              ),
                            ),
                          );
                    },
                    icon: const Icon(Ionicons.send),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
