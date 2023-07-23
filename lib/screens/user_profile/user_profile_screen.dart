import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
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
  int postCount = 0;
  bool isFollowed = false;
  bool isGrid = true;

  @override
  void initState() {
    setPostCount();
    super.initState();
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
      bloc: bloc..add(UserCollectionGetDataEvent(widget.userId)),
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
                          height: 120.h,
                          width: 120.w,
                          boxFit: BoxFit.cover,
                        ),
                        state.userDocument.fullName!.text.make(),
                      ],
                    ),
                    50.widthBox,
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  "Posts".text.bold.make(),
                                  postCount.text.make(),
                                ],
                              ),
                              Column(
                                children: [
                                  "Followers".text.bold.make(),
                                  postCount.text.make(),
                                ],
                              ),
                              Column(
                                children: [
                                  "Following".text.bold.make(),
                                  postCount.text.make(),
                                ],
                              ),
                            ],
                          ),
                          10.heightBox,
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: isFollowed
                                    ? AppColors.transparentColor
                                    : AppColors.primaryColor,
                                border: Border.all(
                                  color: isFollowed
                                      ? AppColors.appBlackColor
                                      : AppColors.primaryColor,
                                ),
                              ),
                              child: buttonText()
                                  .text
                                  .color(isFollowed
                                      ? AppColors.appBlackColor
                                      : AppColors.appWhiteColor)
                                  .make()
                                  .centered(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                              crossAxisCount: 4,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              children: st.posts
                                  .map(
                                    (recipe) => ProfileRecipeImageWidget(
                                        recipe: recipe),
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
