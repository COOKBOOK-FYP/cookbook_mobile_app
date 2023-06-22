import 'package:cookbook/blocs/Users/user_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class PrimaryAppbarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const PrimaryAppbarWidget({Key? key}) : super(key: key);

  @override
  State<PrimaryAppbarWidget> createState() => _PrimaryAppbarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _PrimaryAppbarWidgetState extends State<PrimaryAppbarWidget> {
  late UserBloc bloc;

  @override
  void initState() {
    // bloc = context.read<UserBloc>()..add(UserEventFetch(id: ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserStateSuccess) {
            return AppBar(
              automaticallyImplyLeading: false,
              title: RichText(
                text: TextSpan(
                  text: "Cook",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: "RobotoMono",
                  ),
                  children: [
                    TextSpan(
                      text: "Book",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                // CachedNetworkImage(imageUrl: state.user.photoURL.toString())
                //     .box
                //     .roundedFull
                //     .p1
                //     .color(AppColors.appGreyColor)
                //     .margin(
                //       const EdgeInsets.all(5),
                //     )
                //     .make()
                //     .pOnly(right: 10),
              ],
            );
          }
          return AppBar(
            title: RichText(
              text: TextSpan(
                text: "Cook",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: "RobotoMono",
                ),
                children: [
                  TextSpan(
                    text: "Book",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    Ionicons.person,
                    color: AppColors.appWhiteColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}