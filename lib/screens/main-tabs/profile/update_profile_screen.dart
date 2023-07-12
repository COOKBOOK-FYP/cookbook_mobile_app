// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookbook/blocs/profile/update_profile_bloc.dart';
import 'package:cookbook/blocs/user-collection/user_collection_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/controllers/Post/post_controller.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_image_picker.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/global/utils/media_utils.dart';
import 'package:cookbook/models/User/user_model.dart';
import 'package:cookbook/widgets/appbar/secondary_appbar_widget.dart';
import 'package:cookbook/widgets/buttons/secondary_button_widget.dart';
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

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? image;
  File? compressedImage;
  final profileImageId = const Uuid().v4();
  String photoUrl = "";

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  UserModel user = UserModel();
  UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // initiate form key
    formKey.currentState?.validate();

    context.read<UserCollectionBloc>().add(UserCollectionGetDataEvent(null));
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
    image = null;
    compressedImage = null;

    // dispose controller
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    countryController.dispose();
    dobController.dispose();
    mobileController.dispose();

    // dispose form key
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppbarWidget(title: AppText.updateProfileText),
      body: BlocListener<UserCollectionBloc, UserCollectionState>(
        listener: (context, state) {
          if (state is UserCollectionLoadedState) {
            user = state.userDocument;
            firstNameController.text = user.firstName.toString();
            lastNameController.text = user.lastName.toString();
            mobileController.text = user.phoneNumber.toString();
            bioController.text = user.bio.toString();
            countryController.text = user.country.toString();
            dobController.text = user.dateOfBirth.toString();
            photoUrl = user.photoUrl.toString();

            setState(() {});
          }
        },
        child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
          bloc: updateProfileBloc,
          listener: (context, state) {
            if (state is UpdateProfileSuccessState) {
              AppDialogs.closeDialog();
              AppSnackbars.success(context, state.message);
              context
                  .read<UserCollectionBloc>()
                  .add(UserCollectionGetDataEvent(null));

              // go back to previous page but with new data
              Navigator.pop(context, true);
            } else if (state is UpdateProfileErrorState) {
              AppDialogs.closeDialog();
              AppSnackbars.danger(context, state.message);
            }
          },
          child: Form(
            key: formKey,
            child: PageWidget(
              children: [
                Center(
                  child: Stack(
                    children: [
                      compressedImage == null
                          ? Container(
                              height: 200.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                color: AppColors.appGreyColor,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    user.photoUrl.toString(),
                                    errorListener: () => const Icon(
                                      Ionicons.person_outline,
                                      size: 100,
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                  onError: (exception, stackTrace) =>
                                      const Icon(
                                    Ionicons.person_outline,
                                    size: 100,
                                  ),
                                ),
                              ),
                              child: user.photoUrl.toString() == ""
                                  ? Icon(
                                      Ionicons.person_outline,
                                      color: AppColors.secondaryColor,
                                      size: 100,
                                    )
                                  : null,
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
                          icon: CircleAvatar(
                            backgroundColor: AppColors.secondaryColor,
                            child: const Icon(Ionicons.camera_outline),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.heightBox,
                // Bio

                UpdateTextFieldWidget(
                  controller: bioController,
                  icon: Ionicons.person_outline,
                  hintText: "Bio",
                  maxLines: 3,
                  validator: (p0) => p0!.isEmpty ? "Bio is required" : null,
                ),
                10.heightBox,
                UpdateTextFieldWidget(
                  controller: firstNameController,
                  icon: Ionicons.person_outline,
                  hintText: "First Name",
                ),
                10.heightBox,
                UpdateTextFieldWidget(
                  controller: lastNameController,
                  icon: Ionicons.person_outline,
                  hintText: "Last Name",
                ),
                10.heightBox,
                UpdateTextFieldWidget(
                  controller: mobileController,
                  icon: Ionicons.phone_portrait_outline,
                  hintText: "Phone Number",
                ),
                10.heightBox,
                UpdateTextFieldWidget(
                  controller: countryController,
                  icon: Ionicons.globe_outline,
                  readOnly: true,
                  hintText: "Country",
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      onSelect: (country) {
                        countryController.text = country.name;
                      },
                    );
                  },
                ),
                10.heightBox,
                // date of birth
                UpdateTextFieldWidget(
                  controller: dobController,
                  hintText: "Date of birth",
                  readOnly: true,
                  icon: Ionicons.calendar_outline,
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
                ),
                10.heightBox,
                SecondaryButtonWidget(
                  caption: AppText.updateProfileText,
                  onPressed: () async {
                    try {
                      if (formKey.currentState!.validate()) {
                        AppDialogs.loadingDialog(context);
                        await uploadImageToFirebaseStorageAndDownloadUrl();
                        updateProfileBloc = updateProfileBloc
                          ..add(
                            UpdateProfileOnChangedEvent(
                              bio: bioController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              phoneNumber: mobileController.text.trim(),
                              country: countryController.text.trim(),
                              dateOfBirth: dobController.text.trim(),
                              photoUrl: photoUrl,
                            ),
                          );
                      }
                    } catch (error) {
                      AppDialogs.closeDialog();
                      AppSnackbars.danger(context, "Failed to update profile");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onPressed;
  final IconData icon;
  final String hintText;
  final bool? readOnly;
  final int? maxLines;
  final String? Function(String?)? validator;
  const UpdateTextFieldWidget({
    Key? key,
    required this.controller,
    this.onPressed,
    required this.icon,
    required this.hintText,
    this.readOnly,
    this.maxLines,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return "Field cannot be empty";
            }
            return null;
          },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.appGreyColor.withOpacity(0.5),
        suffixIcon: readOnly == true
            ? IconButton(
                onPressed: onPressed ?? () {},
                icon: CircleAvatar(
                  backgroundColor: AppColors.secondaryColor,
                  child: Icon(
                    icon,
                    color: AppColors.appWhiteColor,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
