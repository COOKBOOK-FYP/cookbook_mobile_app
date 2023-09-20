import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/screens/main-tabs/profile/widgets/profile_header_widget.dart';
import 'package:cookbook/screens/main-tabs/profile/widgets/profile_recipe_image_widget.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/toggle_buttons_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:cookbook/widgets/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isGrid = true;
  @override
  void initState() {
    context.read<FetchPostBloc>().add(FetchCurrentPosts(50, null));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppbarWidget(),
      body: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
          if (state is UserCollectionLoadedState) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      children: [
                        ProfileHeaderWidget(
                          photoUrl: state.userDocument.photoUrl.toString(),
                          firstName: state.userDocument.firstName.toString(),
                          lastName: state.userDocument.lastName.toString(),
                          country: state.userDocument.country.toString(),
                          bio: state.userDocument.bio.toString(),
                          likes: state.userDocument.likes ?? 0,
                          postCount: state.userDocument.postCount ?? 0,
                          birthDate: state.userDocument.dateOfBirth ?? "",
                        ),
                        const Divider(thickness: 1),
                        // switch between list and grid of recipes
                        ToggleButtonsWidget(
                          types: const ["Grid", "List"],
                          onPressed: () {
                            setState(() {
                              isGrid = !isGrid;
                            });
                          },
                        ),

                        10.heightBox,

                        BlocBuilder<FetchPostBloc, FetchPostState>(
                          builder: (context, st) {
                            if (st is FetchPostLoadedState) {
                              return !isGrid
                                  ? ListView.builder(
                                      itemBuilder: (context, index) {
                                        return PostWidget(
                                            post: st.posts[index]);
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
                                            (recipe) =>
                                                ProfileRecipeImageWidget(
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
                    )
                        .box
                        .padding(const EdgeInsets.symmetric(horizontal: 10))
                        .make(),
                  ],
                ),
              ),
            );
          }
          if (state is UserCollectionLoadingState) {
            return const LoadingWidget();
          }

          return const SafeArea(
            child: LoadingWidget(),
          );
        },
      ),
    );
  }
}
