import 'package:cookbook/blocs/post/fetch_post/fetch_all_posts_bloc.dart';
import 'package:cookbook/blocs/post/fetch_post/fetch_post_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_config.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/controllers/PushNotification/push_notification_controller.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/error/error_screen.dart';
import 'package:cookbook/screens/post/post_screen.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/material_button_widget.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:cookbook/widgets/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int paginatedBy = AppConfig.recipesPostPagenatedCount;
  // scroll controller
  ScrollController scrollController = ScrollController();

  // scaffold key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // context.read<UserCollectionBloc>().add(UserCollectionGetDataEvent());
    // increasePaginatedBy();
    // listen for the incoming messages
    PushNotificationController.listenMessages(context);
    // Handle background and terminated state payloads
    PushNotificationController.handlePayloadForTerminatedAndBackground(context);
    context.read<FetchAllPostsBloc>().add(FetchAllPosts(paginatedBy));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void increasePaginatedBy() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <=
          AppConfig.loadOnScrollHeight) {
        paginatedBy += AppConfig.recipesPostPagenatedCount;
        AppConfig.recipesPostMaxCount().then((maxCount) {
          if (paginatedBy <= maxCount) {
            context.read<FetchAllPostsBloc>().add(FetchAllPosts(paginatedBy));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // show dialog to exit app
        return AppDialogs.exitDialog(context);
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<FetchAllPostsBloc>().add(FetchAllPosts(paginatedBy));
        },
        child: Scaffold(
          key: scaffoldKey,
          appBar: const PrimaryAppbarWidget(),
          body: BlocConsumer<FetchAllPostsBloc, FetchPostState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FetchPostErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is FetchPostNoInternetState) {
                return Column(
                  children: [
                    const CreatePostWidget(),
                    20.heightBox,
                    Lottie.asset(LottieAssets.noInternet),
                    20.heightBox,
                    "No internet connection!"
                        .text
                        .maxLines(2)
                        .fontFamily(AppFonts.openSansBold)
                        .makeCentered(),
                    PrimaryButtonWidget(
                      caption: "Retry",
                      onPressed: () {
                        context
                            .read<FetchAllPostsBloc>()
                            .add(FetchAllPosts(paginatedBy));
                      },
                    ),
                  ],
                ).box.make().p20();
              } else if (state is FetchPostEmptyState) {
                return Column(children: [
                  const CreatePostWidget().box.make().p20(),
                  ErrorScreen(
                    lottie: LottieAssets.noPosts,
                    message: "It seems like no one has posted anything yet!",
                    onPressed: () async {
                      context
                          .read<FetchAllPostsBloc>()
                          .add(FetchAllPosts(paginatedBy));
                    },
                    buttonText: "Load Posts",
                  ),
                ]);
              } else if (state is FetchPostLoadedState) {
                return PageWidget(
                  scrollController: scrollController,
                  children: [
                    // what's on your mind
                    const CreatePostWidget(),
                    20.heightBox,
                    ListView.builder(
                      itemBuilder: (context, index) => PostWidget(
                        post: state.posts[index],
                      ),
                      itemCount: state.posts.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                    50.heightBox,
                  ],
                );
              }
              // do nothing, and keep screen as it is
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
