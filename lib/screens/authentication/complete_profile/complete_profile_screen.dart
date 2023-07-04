import 'package:cookbook/blocs/authentication/complete_profile/complete_profile_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/global/utils/app_dialogs.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/global/utils/app_snakbars.dart';
import 'package:cookbook/screens/main-tabs/main_tabs_screen.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:cookbook/widgets/page/page_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
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

  @override
  void dispose() {
    bioController.dispose();
    countryController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CompleteProfileBloc, CompleteProfileState>(
          listener: (context, state) {
            if (state is CompleteProfileLoading) {
              AppDialogs.loadingDialog(context);
            } else if (state is CompleteProfileSuccess) {
              AppDialogs.closeLoadingDialog();
              AppNavigator.replaceTo(
                context: context,
                screen: const MainTabsScreen(),
              );
            } else if (state is CompleteProfileFailed) {
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
                  ),
                  children: [
                    TextSpan(
                      text: " Profile",
                      style: context.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              20.heightBox,
              TextFormField(
                controller: bioController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter your bio",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              20.heightBox,
              // Country Picker
              TextFormField(
                controller: countryController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Enter your location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          countryController.text = country.name;
                        },
                      );
                    },
                    icon: const FieldIcon(icon: Ionicons.flag),
                  ),
                ),
              ),
              20.heightBox,
              // date of birth
              TextFormField(
                controller: dobController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Enter your date of birth",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      // user goe date picker
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((date) {
                        if (date != null) {
                          dobController.text = date.toIso8601String();
                        }
                      });
                    },
                    icon: const FieldIcon(icon: Ionicons.calendar),
                  ),
                ),
              ),
              20.heightBox,
              PrimaryButtonWidget(
                caption: "Continue",
                onPressed: () async {
                  context.read<CompleteProfileBloc>().add(
                        CompleteProfileEventSubmit(
                          bio: bioController.text,
                          country: countryController.text,
                          dateOfBirth: dobController.text,
                        ),
                      );
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
