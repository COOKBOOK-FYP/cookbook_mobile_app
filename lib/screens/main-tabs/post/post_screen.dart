import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    context.read<UserCollectionBloc>().add(UserCollectionGetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: AppText.createPostText),
      body: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
          if (state is UserCollectionLoadingState) {
            return const LoadingWidget();
          }
          if (state is UserCollectionLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 10,
                    decoration: const InputDecoration(
                      hintText: "What's on your mind?",
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(thickness: 2),
                  Row(
                    children: [
                      Icon(
                        Ionicons.image_outline,
                        color: AppColors.secondaryColor,
                      ),
                      const SizedBox(width: 10),
                      "Photo"
                          .text
                          .xl
                          .fontFamily(AppFonts.openSansMedium)
                          .make(),
                    ],
                  ).box.make(),
                ],
              ).box.make().p12(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
