import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/post/post_screen.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/material_button_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:cookbook/widgets/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // context.read<UserCollectionBloc>().add(UserCollectionGetDataEvent());
    context.read<FetchPostBloc>().add(FetchPostGetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppbarWidget(),
      body: BlocConsumer<FetchPostBloc, FetchPostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchPostLoadingState) {
            return const LoadingWidget();
          } else if (state is FetchPostErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is FetchPostEmptyState) {
            return const Center(
              child: Text("No posts found"),
            );
          } else if (state is FetchPostLoadedState) {
            return PageWidget(
              children: [
                // what's on your mind
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: GestureDetector(
                        onTap: () => AppNavigator.goToPage(
                          context: context,
                          screen: const PostScreen(isImagePost: false),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.appBlackColor),
                          ),
                          child: "What's on your mind?".text.make().p12(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButtonWidget(
                        icon: Ionicons.image_outline,
                        iconBgColor: AppColors.primaryColor,
                        size: 25.sp,
                        onPressed: () {
                          AppNavigator.goToPage(
                            context: context,
                            screen: const PostScreen(isImagePost: true),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                20.heightBox,
                SizedBox(
                  height: context.screenHeight,
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        PostWidget(post: state.posts[index]),
                    itemCount: state.posts.length,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }
}
