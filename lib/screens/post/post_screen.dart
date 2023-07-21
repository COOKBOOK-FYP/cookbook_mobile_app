import 'dart:io';

import 'package:cookbook/blocs/post/create_post/post_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_image_picker.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/global/utils/media_utils.dart';
import 'package:cookbook/screens/main-tabs/main_tabs_screen.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/drop_down/drop_down_widget.dart';
import 'package:cookbook/widgets/images/avatar_image_widget.dart';
import 'package:cookbook/widgets/listTile/custom_list_tile.dart';
import 'package:cookbook/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class PostScreen extends StatefulWidget {
  final bool isImagePost;
  const PostScreen({Key? key, required this.isImagePost}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // scaffold key
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // post id
  final postId = const Uuid().v4();

  // Controllers
  final descriptionController = TextEditingController();

  File? image;
  File? compressedImage;
  String foodCategory = AppText.foodCategories[0];
  late String userName;
  late String userImage;

  @override
  void initState() {
    context.read<UserCollectionBloc>().add(UserCollectionGetDataEvent(null));
    if (widget.isImagePost) {
      pickFromGallery();
    }
    super.initState();
  }

  pickFromGallery() async {
    try {
      image = await AppImagePicker.pickFromGallery();
      if (image != null) {
        compressedImage = await MediaUtils.compressImage(
          image!,
          postId: postId,
        );
        setState(() {});
      }
    } catch (error) {
      AppSnackbars.danger(context, error.toString());
    }
  }

  @override
  void dispose() {
    image = null;
    compressedImage = null;
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostLoadingState) {
          AppDialogs.loadingDialog(context);
        } else if (state is PostSubmittedState) {
          AppDialogs.closeDialog();
          Fluttertoast.showToast(
            msg: "Post submitted successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          // Navigator.pop(context);
          // or we can replace the page with main tabs page to get new states
          AppNavigator.replaceTo(
            context: context,
            screen: const MainTabsScreen(),
          );
        } else if (state is PostErrorState) {
          AppDialogs.closeDialog();
          AppSnackbars.danger(context, state.message.toString());
        }
      },
      child: BlocConsumer<UserCollectionBloc, UserCollectionState>(
        listener: (context, state) {
          if (state is UserCollectionLoadedState) {
            userName = state.userDocument.fullName.toString();
            userImage = state.userDocument.photoUrl.toString();
          }
        },
        builder: (context, state) {
          if (state is UserCollectionLoadingState) {
            return const Scaffold(
              body: LoadingWidget(),
            );
          }
          if (state is UserCollectionLoadedState) {
            return Scaffold(
              key: scaffoldKey,
              appBar:
                  const SecondaryAppbarWidget(title: AppText.createPostText),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (compressedImage == null) {
                    AppSnackbars.normal(
                        context, "Please select a recipe image");
                  } else if (foodCategory == AppText.foodCategories.first) {
                    AppSnackbars.normal(
                        context, "Please select a recipe category");
                  } else if (compressedImage != null) {
                    context.read<PostBloc>().add(
                          PostSubmitEvent(
                            compressedImage: compressedImage!,
                            postId: postId,
                            description: descriptionController.text,
                            category: foodCategory,
                            ownerName: userName,
                            ownerPhotoUrl: userImage,
                          ),
                        );
                  }
                },
                backgroundColor: AppColors.primaryColor,
                splashColor: AppColors.secondaryColor,
                child: "Post".text.make(),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AvatarImageWidget(
                          imageUrl: state.userDocument.photoUrl.toString(),
                          height: 60.h,
                          width: 60.w,
                        ),
                        20.widthBox,
                        state.userDocument.fullName.toString().text.xl.make(),
                      ],
                    ).box.make().px16(),

                    TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Say something about this recipe",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ).box.make().px16(),
                    DropDownWidget(
                      onChanged: (String? newValue) {
                        setState(() {
                          foodCategory = newValue!;
                        });
                      },
                      value: foodCategory,
                      items: AppText.foodCategories,
                    )
                        .box
                        .alignCenterRight
                        .margin(const EdgeInsets.only(right: 12))
                        .make()
                        .w(context.width()),
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: compressedImage != null
                            ? Image.file(
                                compressedImage!,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Ionicons.image_outline,
                                size: 80.sp,
                              ),
                      ),
                    ).box.make().p12(),
                    // drop down button

                    20.heightBox,
                    CustomListTile(
                      leadingIcon: Ionicons.image_outline,
                      title: "Photo from gallery",
                      leadingIconBackgroundColor: AppColors.secondaryColor,
                      onTap: () async {
                        await pickFromGallery();
                      },
                    ),
                    const Divider(thickness: 2).box.make().px16(),

                    CustomListTile(
                      leadingIcon: Ionicons.camera_outline,
                      title: "Take a photo",
                      onTap: () async {
                        try {
                          image = await AppImagePicker.pickFromCamera();
                        } catch (error) {
                          AppSnackbars.danger(context, error.toString());
                        }
                      },
                    ),
                    const Divider(thickness: 2).box.make().px16(),
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
