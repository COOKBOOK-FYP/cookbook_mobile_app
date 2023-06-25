import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/screens/profile/widgets/profile_text_widget.dart';
import 'package:cookbook/widgets/appbar/primary_appbar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: CachedNetworkImage(
                              imageUrl: state.userDocument.photoUrl.toString(),
                              width: context.width() * 0.40,
                              height: context.height() * 0.20,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => Icon(
                                Ionicons.person_outline,
                                color: AppColors.primaryColor,
                                size: 50,
                              ),
                            )
                                .box
                                .color(AppColors.appGreyColor)
                                .roundedFull
                                .make(),
                          ),
                          20.widthBox,
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ProfileTextWidget(
                                  text1:
                                      state.userDocument.firstName.toString(),
                                  text2: state.userDocument.lastName.toString(),
                                ),
                                5.heightBox,
                                state.userDocument.address
                                    .toString()
                                    .text
                                    .size(18)
                                    .color(AppColors.appTextColorPrimary)
                                    .make(),
                                10.heightBox,
                                state.userDocument.bio
                                    .toString()
                                    .text
                                    .fontFamily(AppFonts.openSansLight)
                                    .maxLines(2)
                                    .size(15)
                                    .make(),
                              ],
                            ),
                          ),
                        ],
                      ).box.make().wh(context.width(), context.height() * 0.20),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.symmetric(horizontal: 10))
                      .make(),
                ],
              ),
            );
          }
          if (state is UserCollectionLoadingState) {
            return const LoadingWidget();
          }

          return SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
