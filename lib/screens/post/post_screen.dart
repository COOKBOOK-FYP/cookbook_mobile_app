import 'dart:io';

import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_image_picker.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/listTile/custom_list_tile.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class PostScreen extends StatefulWidget {
  final bool isImagePost;
  const PostScreen({Key? key, required this.isImagePost}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File? image;

  @override
  void initState() {
    context.read<UserCollectionBloc>().add(UserCollectionGetDataEvent());
    if (widget.isImagePost) {
      AppImagePicker.pickFromGallery().then((img) {
        setState(() {
          image = img;
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: AppText.createPostText),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        splashColor: AppColors.secondaryColor,
        child: "Post".text.make(),
      ),
      body: BlocBuilder<UserCollectionBloc, UserCollectionState>(
        builder: (context, state) {
          if (state is UserCollectionLoadingState) {
            return const LoadingWidget();
          }
          if (state is UserCollectionLoadedState) {
            return SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Say something about this recipe",
                        border: InputBorder.none,
                      ),
                    ).box.make().px16(),
                    // const Divider(thickness: 2).box.make().px16(),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: image != null
                            ? Image.file(image!)
                            : Icon(
                                Ionicons.image_outline,
                                size: 80.sp,
                              ),
                      ),
                    ).box.make().p12(),
                    20.heightBox,
                    CustomListTile(
                      leadingIcon: Ionicons.image_outline,
                      title: "Photo from gallery",
                      leadingIconBackgroundColor: AppColors.secondaryColor,
                      onTap: () async {
                        try {
                          image = await AppImagePicker.pickFromGallery();
                        } catch (error) {
                          AppSnackbars.danger(context, error.toString());
                        }
                      },
                    ),
                    const Divider(thickness: 2).box.make().px16(),
                    CustomListTile(
                      leadingIcon: Ionicons.camera_outline,
                      title: "Take a photo",
                      onTap: () {},
                    ),
                    const Divider(thickness: 2).box.make().px16(),
                    30.heightBox,
                    // PrimaryButtonWidget(
                    //   caption: "Post Recipe",
                    //   onPressed: () {},
                    // ).box.make().px16(),
                  ],
                ).box.make(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
