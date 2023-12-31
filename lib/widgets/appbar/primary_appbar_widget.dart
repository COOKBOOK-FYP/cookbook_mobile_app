import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/search/search_user_screen.dart';
import 'package:cookbook/screens/settings/settings_screen.dart';
import 'package:cookbook/screens/user_profile/user_profile_screen.dart';
import 'package:cookbook/widgets/buttons/round_icon_button.dart';
import 'package:cookbook/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PrimaryAppbarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const PrimaryAppbarWidget({Key? key}) : super(key: key);

  @override
  State<PrimaryAppbarWidget> createState() => _PrimaryAppbarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _PrimaryAppbarWidgetState extends State<PrimaryAppbarWidget> {
  @override
  void initState() {
    context.read<UserCollectionBloc>().add(UserCollectionGetDataEvent(null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
          if (state is UserCollectionLoadingState) {
            return Shimmer(
              colorOpacity: 0.5,
              duration: const Duration(milliseconds: 1000),
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: RichText(
                  text: TextSpan(
                    text: "Cook",
                    style: TextStyle(
                      color: AppColors.appDarkGreyColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.openSansBold,
                    ),
                    children: [
                      TextSpan(
                        text: "Book",
                        style: TextStyle(
                          color: AppColors.appDarkGreyColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.robotoLight,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  RoundIconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.search_outline),
                  ),
                  RoundIconButton(
                    onPressed: () {},
                    icon: const Icon(Ionicons.settings_outline),
                  ),
                  Container(
                    width: 50.w,
                    height: 50.w,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.appBlackColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(Ionicons.person),
                  ),
                ],
              ),
            );
          }
          if (state is UserCollectionLoadedState) {
            return AppBar(
              automaticallyImplyLeading: false,
              title: RichText(
                text: TextSpan(
                  text: "Cook",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.openSansBold,
                  ),
                  children: [
                    TextSpan(
                      text: "Book",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.robotoLight,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                RoundIconButton(
                  onPressed: () {
                    AppNavigator.goToPage(
                      context: context,
                      screen: const SearchUserScreen(),
                    );
                  },
                  icon: const Icon(Ionicons.search_outline),
                ),
                RoundIconButton(
                  onPressed: () {
                    AppNavigator.goToPage(
                      context: context,
                      screen: const SettingsScreen(),
                    );
                  },
                  icon: const Icon(Ionicons.settings_outline),
                ),
                CircularImage(
                  imageUrl: state.userDocument.photoUrl.toString(),
                  onTap: () {
                    AppNavigator.goToPage(
                      context: context,
                      screen:
                          UserProfileScreen(userId: state.userDocument.userId!),
                    );
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
