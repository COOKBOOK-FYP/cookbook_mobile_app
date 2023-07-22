import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/models/Notification/notification_model.dart';
import 'package:cookbook/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:velocity_x/velocity_x.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationModel notificationModel;
  const NotificationWidget({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  final userBloc = UserCollectionBloc();
  @override
  void initState() {
    userBloc.add(UserCollectionGetDataEvent(widget.notificationModel.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (BlocBuilder<UserCollectionBloc, UserCollectionState>(
      bloc: userBloc,
      builder: (context, state) {
        if (state is UserCollectionLoadedState) {
          return Column(
            children: [
              ListTile(
                // tileColor: AppColors.primaryColor.withOpacity(0.1),
                // tileColor: AppColors.appGreyColor,
                isThreeLine: true,
                leading: CircularImage(
                  imageUrl: state.userDocument.photoUrl.toString(),
                ),
                title: state.userDocument.fullName.toString().text.make(),
                subtitle: (widget.notificationModel.type == 'like')
                    ?
                    // "liked your post - ${timeago.format(widget.notificationModel.createdAt!.toDate())}"
                    //     .text
                    //     .make()
                    RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'liked your post - ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppFonts.robotoMonoLight,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: timeago.format(
                                  widget.notificationModel.createdAt!.toDate()),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppFonts.openSansMedium,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'commented on your post - ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppFonts.robotoMonoLight,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: timeago.format(
                                  widget.notificationModel.createdAt!.toDate()),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppFonts.openSansMedium,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '\n\n${widget.notificationModel.commentData}',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppFonts.robotoMonoLight,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                // "commented on your post - ${timeago.format(widget.notificationModel.createdAt!.toDate())}\n\n\n${widget.notificationModel.commentData}"
                //     .text
                //     .make(),
                trailing: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    widget.notificationModel.mediaUrl.toString(),
                  ),
                  onBackgroundImageError: (exception, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
              const Divider(thickness: 1),
            ],
          );
        }
        return Container();
      },
    ));
  }
}
