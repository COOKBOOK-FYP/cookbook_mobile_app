import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/firebase_constants.dart';
import 'package:cookbook/widgets/buttons/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class PrimaryAppbarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const PrimaryAppbarWidget({Key? key, this.actions}) : super(key: key);
  final List<Widget>? actions;

  @override
  State<PrimaryAppbarWidget> createState() => _PrimaryAppbarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _PrimaryAppbarWidgetState extends State<PrimaryAppbarWidget> {
  @override
  void initState() {
    context
        .read<UserCollectionBloc>()
        .add(UserCollectionGetDataEvent(FirebaseContants.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
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
                  onPressed: () {},
                  icon: Icon(
                    Ionicons.search_outline,
                  ),
                ),
                RoundIconButton(
                  onPressed: () {},
                  icon: Icon(
                    Ionicons.settings_outline,
                  ),
                ),
                RoundIconButton(
                  onPressed: () {},
                  icon: state.userDocument['photoUrl'] != ""
                      ? CachedNetworkImage(
                          imageUrl: state.userDocument['photoUrl'].toString(),
                          errorWidget: (context, url, error) =>
                              const Icon(Ionicons.person_outline),
                        )
                      : const Icon(Ionicons.person_outline),
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
