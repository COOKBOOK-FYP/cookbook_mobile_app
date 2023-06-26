import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/sign-out/sign_out_screen.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/listTile/custom_list_tile.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: AppText.settingsText),
      body: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
          if (state is UserCollectionLoadedState) {
            return PageWidget(
              children: [
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: state.userDocument.photoUrl.toString(),
                    errorWidget: (context, url, error) =>
                        const Icon(Ionicons.person),
                  ).box.roundedFull.color(AppColors.appGreyColor).make().p1(),
                  title:
                      '${state.userDocument.firstName} ${state.userDocument.lastName}'
                          .text
                          .xl2
                          .bold
                          .make(),
                  subtitle: state.userDocument.email?.text.make(),
                  trailing: const Icon(Ionicons.pencil_outline),
                ),
                50.heightBox,
                CustomListTile(
                  title: "Themes",
                  leadingIcon: Ionicons.color_palette_outline,
                  onTap: () {},
                ),
                CustomListTile(
                  title: AppText.deleteAccountText,
                  leadingIcon: Ionicons.trash_outline,
                  onTap: () {},
                ),
                CustomListTile(
                  title: AppText.signOutText,
                  leadingIcon: Ionicons.log_out_outline,
                  onTap: () {
                    AppNavigator.goToPage(
                      context: context,
                      screen: const SignOutScreen(),
                    );
                  },
                ),
              ],
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
