import 'package:cookbook/blocs/follow_and_unfollow/follow_unfollow_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FollowFollowingButton extends StatelessWidget {
  final bool isFollowed;
  final FollowUnfollowBloc followUnfollowBloc;
  final String userId;
  final String buttonText;
  const FollowFollowingButton(
      {Key? key,
      required this.isFollowed,
      required this.followUnfollowBloc,
      required this.userId,
      required this.buttonText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isFollowed) {
          followUnfollowBloc.add(
            FollowUnfollowUnfollowEvent(otherUserId: userId),
          );
        } else {
          followUnfollowBloc.add(
            FollowUnfollowFollowEvent(otherUserId: userId),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isFollowed ? AppColors.appWhiteColor : AppColors.primaryColor,
          border: Border.all(
            color:
                isFollowed ? AppColors.appBlackColor : AppColors.primaryColor,
          ),
        ),
        child: buttonText.text
            .color(
              isFollowed ? AppColors.appBlackColor : AppColors.appWhiteColor,
            )
            .make()
            .centered(),
      ),
    );
  }
}
