import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:velocity_x/velocity_x.dart';

class CommentWidget extends StatefulWidget {
  final String userId;
  final String comment;
  final Timestamp? createdAt;
  final String username;
  final Color? commentBackgroundColor;
  const CommentWidget({
    super.key,
    required this.userId,
    required this.comment,
    this.createdAt,
    required this.username,
    this.commentBackgroundColor,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  UserCollectionBloc userCollectionBloc = UserCollectionBloc();

  @override
  void initState() {
    userCollectionBloc = userCollectionBloc
      ..add(
        UserCollectionGetDataEvent(widget.userId),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      bloc: userCollectionBloc,
      builder: (context, state) {
        if (state is UserCollectionLoadedState) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  // Navigate To User Profile screen based on user id
                  print(widget.userId);
                },
                leading: CircularImage(
                  imageUrl: state.userDocument.photoUrl.toString(),
                  borderColor: AppColors.transparentColor,
                ),
                title: state.userDocument.fullName
                    .toString()
                    .text
                    .fontFamily(AppFonts.robotoMonoBold)
                    .make(),
                trailing: widget.createdAt != null
                    ? timeago
                        .format(
                          widget.createdAt!.toDate(),
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
                  color: widget.commentBackgroundColor ??
                      AppColors.secondaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: widget.comment.text
                    .fontFamily(AppFonts.openSansMedium)
                    .make(),
              ),
              const Divider(),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
