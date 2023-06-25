import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/splash/splash_screen.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  logOut() {
    FirebaseAuth.instance.signOut().then((_) async {
      AppDialogs.loadingDialog(context);
      Future.delayed(3.seconds, () {
        AppDialogs.closeLoadingDialog();
        AppNavigator.replaceTo(
          context: context,
          screen: const SplashScreen(),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                ListTile(
                  trailing: Icon(
                    Ionicons.log_out_outline,
                    size: 30,
                    color: AppColors.appBlackColor,
                  ),
                  title: AppText.signOutText.text.xl2.make(),
                  onTap: () => logOut(),
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
