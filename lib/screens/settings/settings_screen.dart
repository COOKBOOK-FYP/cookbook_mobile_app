import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/delete-account/delete_account_screen.dart';
import 'package:cookbook/screens/authentication/sign-out/sign_out_screen.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/material_button_widget.dart';
import 'package:cookbook/widgets/images/avatar_image_widget.dart';
import 'package:cookbook/widgets/listTile/custom_list_tile.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:cookbook/widgets/text/primary_text_widget.dart';
import 'package:cookbook/widgets/text/secondary_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            return Column(
              children: [
                // ListTile(
                //   shape: RoundedRectangleBorder(
                //     side: const BorderSide(width: 1),
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   leading: CircleAvatarWidget(
                //     photoUrl: state.userDocument.photoUrl.toString(),
                //     iconColor: AppColors.secondaryColor,
                //   ),
                //   title: Text(
                //     '${state.userDocument.firstName} ${state.userDocument.lastName}',
                //   ),
                //   subtitle: Text(state.userDocument.email.toString()),
                //   trailing: const Icon(Ionicons.pencil_outline),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvatarImageWidget(
                      height: 80.h,
                      width: 80.w,
                      imageUrl: state.userDocument.photoUrl.toString(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryTextWidget(
                          text: state.userDocument.fullName.toString(),
                        ),
                        SecondaryTextWidget(
                          text: state.userDocument.email.toString(),
                          fontColor: Colors.grey,
                          fontSize: 13,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    MaterialButtonWidget(
                      icon: Ionicons.pencil,
                      onPressed: () {},
                    ),
                  ],
                ).box.make().px(10),
                Divider(color: AppColors.primaryColor),
                30.heightBox,
                CustomListTile(
                  title: "Themes",
                  leadingIcon: Ionicons.color_palette_outline,
                  onTap: () {},
                ),
                CustomListTile(
                  title: AppText.deleteAccountText,
                  leadingIcon: Ionicons.trash_outline,
                  onTap: () {
                    AppNavigator.goToPage(
                      context: context,
                      screen: const DeleteAccountScreen(),
                    );
                  },
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
