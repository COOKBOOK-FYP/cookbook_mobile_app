import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/blocs/comments/comments_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/models/Comments/comment_model.dart';
import 'package:cookbook/models/Recipes/recipe_model.dart';
import 'package:cookbook/models/User/user_model.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
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
              return const LoadingWidget();
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
                        onPressed: () {
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
                              ),
                            );
                            commentsController.clear();
                          }
                        },
                        icon: const Icon(Icons.send),
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
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                // Navigate To User Profile screen based on user id
                                print(state.comments[index].userId);
                              },
                              title:
                                  state.comments[index].username?.text.make(),
                              trailing: state.comments[index].createdAt != null
                                  ? timeago
                                      .format(
                                        state.comments[index].createdAt!
                                            .toDate(),
                                      )
                                      .text
                                      .make()
                                  : const SizedBox(),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.appGreyColor,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              child: state.comments[index].comment?.text.make(),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                      itemCount: state.comments.length,
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
                          hintText: "Add a comment",
                          border: InputBorder.none,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
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
                              ),
                            );
                            commentsController.clear();
                          }
                        },
                        icon: const Icon(Icons.send),
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
