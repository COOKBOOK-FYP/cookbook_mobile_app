import 'package:cookbook/blocs/follow_and_unfollow/follow_unfollow_bloc.dart';
import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/main-tabs/profile/update_profile_screen.dart';
import 'package:cookbook/screens/main-tabs/profile/widgets/profile_recipe_image_widget.dart';
import 'package:cookbook/screens/user_profile/widgets/follow_unfollow_button.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/toggle_buttons_widget.dart';
import 'package:cookbook/widgets/images/avatar_image_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:cookbook/widgets/post/post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  final bool? followBack;
  const UserProfileScreen({Key? key, required this.userId, this.followBack})
      : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final userCollectionBloc = UserCollectionBloc();
  final followUnfollowBloc = FollowUnfollowBloc();
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowed = false;
  bool isGrid = true;

  @override
  void initState() {
    userCollectionBloc.add(UserCollectionGetDataEvent(widget.userId));
    setPostCount();
    setFollowersCount();
    setFollowingCount();
    checkFollow();
    super.initState();
  }

  void checkFollow() {
    FirebaseContants.followingCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userFollowing')
        .doc(widget.userId)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          isFollowed = true;
        });
      } else {
        setState(() {
          isFollowed = false;
        });
      }
    });
  }

  void setPostCount() {
    int count = 0;
    FirebaseContants.recipesCollection
        .doc(widget.userId)
        .collection('UserPosts')
        .get()
        .then((value) {
      count = value.size;
      postCount = count;
    });
  }

  void setFollowersCount() {
    int count = 0;
    FirebaseContants.followersCollection
        .doc(widget.userId)
        .collection('userFollowers')
        .get()
        .then((value) {
      count = value.size;
      followersCount = count;
    });
  }

  void setFollowingCount() {
    int count = 0;
    FirebaseContants.followingCollection
        .doc(widget.userId)
        .collection('userFollowing')
        .get()
        .then((value) {
      count = value.size;
      followingCount = count;
    });
  }

  String buttonText() {
    if (widget.userId == FirebaseAuth.instance.currentUser!.uid) {
      return "Edit profile";
    } else if (isFollowed) {
      return "Following";
    } else {
      if (widget.followBack != null) {
        return "Follow back";
      }
      return "Follow";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      bloc: userCollectionBloc,
      builder: (context, state) {
        if (state is UserCollectionLoadedState) {
          return Scaffold(
            appBar: SecondaryAppbarWidget(
              title: state.userDocument.fullName.toString(),
            ),
            body: PageWidget(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        AvatarImageWidget(
                          imageUrl: state.userDocument.photoUrl.toString(),
                          height: 100.h,
                          width: 100.w,
                          boxFit: BoxFit.cover,
                        ),
                      ],
                    ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  "Posts".text.size(16).bold.make(),
                                  postCount.text.make(),
                                ],
                              ),
                              Column(
                                children: [
                                  "Followers".text.bold.size(16).make(),
                                  followersCount.text.make(),
                                ],
                              ),
                              Column(
                                children: [
                                  "Following".text.bold.size(16).make(),
                                  followingCount.text.make(),
                                ],
                              ),
                            ],
                          ),
                          10.heightBox,
                          buttonText() != "Edit profile"
                              ? BlocListener<FollowUnfollowBloc,
                                  FollowUnfollowState>(
                                  bloc: followUnfollowBloc,
                                  listener: (context, state) {
                                    if (state is FollowUnfollowLoadingState) {
                                      setState(() {
                                        isFollowed = !isFollowed;
                                        setFollowersCount();
                                        setFollowingCount();
                                      });
                                    }
                                    if (state is FollowUnfollowTrueState) {
                                      setState(() {
                                        isFollowed = true;
                                        setFollowersCount();
                                        setFollowingCount();
                                        toast("Followed");
                                      });
                                    } else if (state
                                        is FollowUnfollowFalseState) {
                                      setState(() {
                                        isFollowed = false;
                                        setFollowersCount();
                                        setFollowingCount();
                                        toast("Unfollowed");
                                      });
                                    }

                                    if (state is FollowUnfollowFailureState) {
                                      toast("Something went wrong");
                                      setState(() {
                                        isFollowed = !isFollowed;
                                      });
                                    }
                                  },
                                  child: FollowFollowingButton(
                                    isFollowed: isFollowed,
                                    followUnfollowBloc: followUnfollowBloc,
                                    userId: widget.userId,
                                    buttonText: buttonText(),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    AppNavigator.goToPage(
                                      context: context,
                                      screen: UpdateProfileScreen(
                                        userCollectionBloc: userCollectionBloc,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: isFollowed
                                          ? AppColors.secondaryColor
                                          : AppColors.primaryColor,
                                    ),
                                    child: buttonText()
                                        .text
                                        .color(AppColors.appWhiteColor)
                                        .make()
                                        .centered(),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.heightBox,
                state.userDocument.fullName
                    .toString()
                    .text
                    .xl
                    .fontFamily(AppFonts.openSansBold)
                    .make()
                    .centered(),
                state.userDocument.bio.toString().text.make(),
                30.heightBox,
                Row(
                  children: [
                    const Icon(Ionicons.location_outline),
                    20.width,
                    "Country: ${state.userDocument.country.toString()}"
                        .text
                        .make(),
                  ],
                ),
                10.heightBox,
                Row(
                  children: [
                    const Icon(Ionicons.calendar_outline),
                    20.width,
                    "Birth : ${state.userDocument.dateOfBirth.toString()}"
                        .text
                        .make(),
                  ],
                ),
                const Divider(thickness: 1),
                ToggleButtonsWidget(
                  types: const ["Grid", "List"],
                  onPressed: () {
                    setState(() {
                      isGrid = !isGrid;
                    });
                  },
                ),
                20.heightBox,
                BlocBuilder<FetchPostBloc, FetchPostState>(
                  bloc: FetchPostBloc()
                    ..add(
                      FetchCurrentPosts(500, widget.userId),
                    ),
                  builder: (context, st) {
                    if (st is FetchPostLoadedState) {
                      return !isGrid
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return PostWidget(post: st.posts[index]);
                              },
                              itemCount: st.posts.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                            )
                          : StaggeredGrid.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 3,
                              crossAxisSpacing: 3,
                              children: st.posts
                                  .map(
                                    (recipe) => ProfileRecipeImageWidget(
                                      recipe: recipe,
                                    ),
                                  )
                                  .toList(),
                            );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          );
        }
        return const Scaffold(
          appBar: SecondaryAppbarWidget(title: ""),
          body: LoadingWidget(),
        );
      },
    );
  }
}
