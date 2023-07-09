import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/screens/main-tabs/profile/widgets/profile_header_widget.dart';
import 'package:cookbook/screens/main-tabs/profile/widgets/profile_recipe_image_widget.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
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
  @override
  void initState() {
    context.read<FetchPostBloc>().add(FetchCurrentPosts(20));
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
                        ),
                        const VxDivider(type: VxDividerType.horizontal),
                        BlocBuilder<FetchPostBloc, FetchPostState>(
                          builder: (context, st) {
                            if (st is FetchPostLoadedState) {
                              return StaggeredGrid.count(
                                crossAxisCount: 4,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
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
