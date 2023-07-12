// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cookbook/blocs/authentication/complete_profile/complete_profile_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/controllers/Post/post_controller.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_image_picker.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/global/utils/media_utils.dart';
import 'package:cookbook/screens/main-tabs/main_tabs_screen.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  // Controllers
  TextEditingController bioController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  File? image;
  File? compressedImage;

  String profileImageId = const Uuid().v4();

  String photoUrl = "";

  @override
  void initState() {
    bioController.text = 'Hey there! I am using Cookbook';
    super.initState();
  }

  pickFromGallery() async {
    try {
      image = await AppImagePicker.pickFromGallery();
      if (image != null) {
        compressedImage = await MediaUtils.compressImage(
          image!,
          postId: profileImageId,
        );
        setState(() {});
      }
    } catch (error) {
      AppSnackbars.danger(context, error.toString());
    }
  }

  uploadImageToFirebaseStorageAndDownloadUrl() async {
    if (image != null) {
      compressedImage =
          await MediaUtils.compressImage(image!, postId: profileImageId);
      photoUrl = await PostController.uploadImageToStorageAndGet(
        compressedImage!,
        profileImageId,
        child: FirebaseStorage.instance
            .ref()
            .child("profile_images/$profileImageId.jpg")
            .putFile(compressedImage!),
      );
    } else {
      photoUrl = "";
    }
  }

  @override
  void dispose() {
    bioController.dispose();
    countryController.dispose();
    dobController.dispose();

    image = null;
    compressedImage = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CompleteProfileBloc, CompleteProfileState>(
          listener: (context, state) {
            // if (state is CompleteProfileLoading) {
            //   AppDialogs.loadingDialog(context);
            // } else
            if (state is CompleteProfileSuccess) {
              AppDialogs.closeDialog();
              AppNavigator.replaceTo(
                context: context,
                screen: const MainTabsScreen(),
              );
            } else if (state is CompleteProfileFailed) {
              AppDialogs.closeDialog();
              AppSnackbars.danger(context, state.error);
            }
          },
          child: PageWidget(
            children: [
              RichText(
                text: TextSpan(
                  text: "Complete",
                  style: context.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    fontFamily: AppFonts.robotoMonoLight,
                  ),
                  children: [
                    TextSpan(
                      text: " Profile",
                      style: context.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppColors.secondaryColor,
                        fontFamily: AppFonts.robotoMonoMedium,
                      ),
                    ),
                  ],
                ),
              ),
              20.heightBox,
              // Pick Image and show it as circle avatar
              Stack(
                children: [
                  compressedImage == null
                      ? CircleAvatar(
                          radius: 100.r,
                          backgroundColor: AppColors.appGreyColor,
                          child: Icon(Ionicons.person, size: 80.sp),
                        )
                      : Container(
                          height: 200.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(compressedImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () async {
                        await pickFromGallery();
                      },
                      icon: const CircleAvatar(
                        child: Icon(Ionicons.camera_outline),
                      ),
                    ),
                  ),
                ],
              ),
              20.heightBox,

              // Bio
              TextFormField(
                controller: bioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Enter your bio",
                  border: UnderlineInputBorder(),
                ),
              ),
              20.heightBox,
              // Country Picker
              TextFormField(
                controller: countryController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Select your country",
                  suffixIcon: IconButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false,
                        onSelect: (country) {
                          countryController.text = country.name;
                        },
                      );
                    },
                    icon: const FieldIcon(icon: Ionicons.globe_outline),
                  ),
                ),
              ),
              20.heightBox,
              // date of birth
              TextFormField(
                controller: dobController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Select your date of birth",
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        // user Intl package to format date
                        dobController.text = DateFormat.yMMMd().format(date);
                      }
                    },
                    icon: const FieldIcon(icon: Ionicons.calendar_outline),
                  ),
                ),
              ),
              20.heightBox,
              PrimaryButtonWidget(
                caption: "Continue",
                onPressed: () async {
                  if (bioController.text.isEmpty) {
                    AppSnackbars.danger(context, "Bio is required");
                    return;
                  }
                  if (countryController.text.isEmpty) {
                    AppSnackbars.danger(context, "Country is required");
                    return;
                  }
                  if (dobController.text.isEmpty) {
                    AppSnackbars.danger(context, "Date of birth is required");
                    return;
                  }
                  try {
                    AppDialogs.loadingDialog(context);
                    await uploadImageToFirebaseStorageAndDownloadUrl();
                    context.read<CompleteProfileBloc>().add(
                          CompleteProfileEventSubmit(
                            bio: bioController.text.trim(),
                            country: countryController.text.trim(),
                            dateOfBirth: dobController.text.trim(),
                            photoUrl: photoUrl,
                          ),
                        );
                  } catch (error) {
                    AppDialogs.closeDialog();
                    AppSnackbars.danger(context, error.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldIcon extends StatelessWidget {
  final IconData icon;
  const FieldIcon({Key? key, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Icon(
        icon,
        color: AppColors.backgroundColor,
        size: 20.sp,
      ),
    );
  }
}
