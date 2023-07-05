// ignore_for_file: unnecessary_string_interpolations

import 'package:cookbook/blocs/authentication/signUp/signup_bloc.dart';
import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/global/utils/app_navigator.dart';
import 'package:cookbook/screens/authentication/sign-up/signup_completed_screen.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:cookbook/widgets/text/primary_text_widget.dart';
import 'package:cookbook/widgets/text_fields/password_text_field_widget.dart';
import 'package:cookbook/widgets/text_fields/text_field_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formGlobalKey = GlobalKey<FormState>();

// controllers for the text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // focus nodes for the text fields
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  BuildContext? dialogueContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // dispose all the controllers
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();

    // dispose all the focus nodes
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneNumberFocusNode.dispose();

    // close the dialogue context
    if (dialogueContext != null) {
      Navigator.of(dialogueContext!).pop();
      dialogueContext = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          return currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupStateLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) {
                    dialogueContext = ctx;
                    return Container(
                      color: AppColors.transparentColor,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primaryColor,
                          size: 30.0,
                        ),
                      ),
                    );
                  });
            }

            if (state is SignupStateSuccess) {
              AppNavigator.replaceTo(
                context: context,
                screen: const SignupCompletedScreen(),
              );
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: context.width(),
                  height: context.height() * 0.35,
                  child: Stack(children: <Widget>[
                    Image.asset(
                      AppImages.signUpCover,
                      width: context.width(),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Ionicons.chevron_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          PrimaryTextWidget(
                            text: AppText.signupText,
                            fontSize: 25.sp,
                            fontColor: Colors.white,
                            fontFamily: AppFonts.openSansBold,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Form(
                  key: formGlobalKey,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: _firstNameController,
                          focusNode: _firstNameFocusNode,
                          nextFocusNode: _lastNameFocusNode,
                          prefixIcon: Ionicons.person_outline,
                          label: AppText.firstNameText,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter first name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFieldWidget(
                          controller: _lastNameController,
                          focusNode: _lastNameFocusNode,
                          nextFocusNode: _emailFocusNode,
                          prefixIcon: Ionicons.person_outline,
                          label: AppText.lastNameText,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter last name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFieldWidget(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          nextFocusNode: _phoneNumberFocusNode,
                          prefixIcon: Ionicons.mail_outline,
                          label: AppText.emailText,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter email address";
                            } else if (EmailValidator.validate(val) == false) {
                              return "Please enter valid email address";
                            } else if (val.length > 50) {
                              return "Email length should be less than 50";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        // MobileNumberTextField(
                        //   controller: _phoneNumberController,
                        //   validator: (val) {
                        //     if (val!.isEmpty) {
                        //       return "Please enter phone number";
                        //     } else if (val.length > 13) {
                        //       return "Password length should be equal to 11";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        TextFieldWidget(
                          controller: _phoneNumberController,
                          focusNode: _phoneNumberFocusNode,
                          nextFocusNode: _passwordFocusNode,
                          prefixIcon: Ionicons.phone_portrait_outline,
                          label: AppText.phoneNumberText,
                          validator: (number) {
                            if (number!.isEmpty) {
                              return "Please enter phone number";
                            } else if (!RegExp(r'^\+?[1-9]\d{1,14}$')
                                .hasMatch(number)) {
                              return "Please enter valid phone number";
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        PasswordTextFieldWidget(
                          controller: _passwordController,
                          prefixIcon: Ionicons.lock_closed_outline,
                          focusNode: _passwordFocusNode,
                          label: AppText.passwordText,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter password";
                            } else if (val.length < 8) {
                              return "Password length should be greater than 8";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                  child: PrimaryButtonWidget(
                      width: context.width(),
                      height: 50.h,
                      caption: AppText.signupText,
                      onPressed: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          BlocProvider.of<SignupBloc>(context).add(
                            SignupWithCredentialsEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              phoneNumber: _phoneNumberController.text,
                            ),
                          );
                        }
                      }),
                ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                //   child: Row(children: <Widget>[
                //     const Expanded(
                //         child: Divider(
                //       color: Colors.black,
                //     )),
                //     Padding(
                //       padding: EdgeInsets.only(left: 10.w, right: 10.w),
                //       child: PrimaryTextWidget(
                //         text: AppText.continueWithText,
                //         fontSize: 14.sp,
                //         fontColor: Colors.black,
                //         fontFamily: AppFonts.openSansLight,
                //       ),
                //     ),
                //     const Expanded(
                //         child: Divider(
                //       color: Colors.black,
                //     )),
                //   ]),
                // ),
                // SizedBox(height: 20.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       padding: EdgeInsets.all(8.w),
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           borderRadius: BorderRadius.circular(8.r)),
                //       child: const Icon(
                //         Ionicons.logo_facebook,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10.w,
                //     ),
                //     Container(
                //       padding: EdgeInsets.all(8.w),
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           borderRadius: BorderRadius.circular(8.r)),
                //       child: const Icon(
                //         Ionicons.logo_google,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10.w,
                //     ),
                //     Container(
                //       padding: EdgeInsets.all(8.w),
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           borderRadius: BorderRadius.circular(8.r)),
                //       child: const Icon(
                //         Ionicons.logo_apple,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(left: 10.w, right: 10.w),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       PrimaryTextWidget(
                //         text: AppText.alreadyHaveAnAccountText,
                //         fontSize: 14.sp,
                //         fontFamily: AppFonts.openSansLight,
                //       ),
                //       SizedBox(
                //         width: 5.w,
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.of(context).pop();
                //         },
                //         child: PrimaryTextWidget(
                //           text: AppText.signinText,
                //           fontSize: 14.sp,
                //           fontColor: Colors.black,
                //           fontFamily: AppFonts.robotoBold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10.h,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
