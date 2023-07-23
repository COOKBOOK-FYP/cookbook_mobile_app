import 'package:cookbook/blocs/follow_and_unfollow/follow_unfollow_bloc.dart';
import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/screens/main-tabs/profile/widgets/profile_recipe_image_widget.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
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
import 'package:velocity_x/velocity_x.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final bloc = UserCollectionBloc();
  final followUnfollowBloc = FollowUnfollowBloc();
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowed = false;
  bool isGrid = true;

  @override
  void initState() {
    bloc.add(UserCollectionGetDataEvent(widget.userId));
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
      return "Follow";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is UserCollectionLoadedState) {
          return Scaffold(
            appBar: SecondaryAppbarWidget(
              title: state.userDocument.fullName.toString(),
            ),
            body: PageWidget(
              children: [
                // ProfileHeaderWidget(
                //   photoUrl: state.userDocument.photoUrl.toString(),
                //   firstName: state.userDocument.firstName.toString(),
                //   lastName: state.userDocument.lastName.toString(),
                //   country: state.userDocument.country.toString(),
                //   bio: state.userDocument.bio.toString(),
                //   likes: state.userDocument.likes!,
                //   postCount: state.userDocument.postCount!,
                // ),
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
                                    if (state is FollowUnfollowTrueState) {
                                      setState(() {
                                        isFollowed = true;
                                        setFollowersCount();
                                        setFollowingCount();
                                      });
                                    } else if (state
                                        is FollowUnfollowFalseState) {
                                      setState(() {
                                        isFollowed = false;
                                        setFollowersCount();
                                        setFollowingCount();
                                      });
                                    }
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      if (isFollowed) {
                                        followUnfollowBloc.add(
                                          FollowUnfollowUnfollowEvent(
                                              otherUserId: widget.userId),
                                        );
                                      } else {
                                        followUnfollowBloc.add(
                                          FollowUnfollowFollowEvent(
                                              otherUserId: widget.userId),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        color: isFollowed
                                            ? AppColors.appBlackColor
                                            : AppColors.primaryColor,
                                      ),
                                      child: buttonText()
                                          .text
                                          .color(AppColors.appWhiteColor)
                                          .make()
                                          .centered(),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {},
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
                const Divider(thickness: 1),

                // switch between list and grid of recipes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isGrid = true;
                        });
                      },
                      icon: isGrid
                          ? Icon(Ionicons.grid, color: AppColors.primaryColor)
                          : const Icon(Ionicons.grid_outline),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isGrid = false;
                        });
                      },
                      icon: !isGrid
                          ? Icon(Ionicons.list, color: AppColors.primaryColor)
                          : const Icon(Ionicons.list_outline),
                    ),
                  ],
                ),
                20.heightBox,
                // const ProfileRecipeListWidget(),

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
