// ignore_for_file: prefer_const_constructors

import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_fonts.dart';
import 'package:cookbook/constants/app_images.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:cookbook/widgets/buttons/primary_button_widget.dart';
import 'package:cookbook/widgets/text/primary_text_widget.dart';
import 'package:cookbook/widgets/text_fields/password_text_field_widget.dart';
import 'package:cookbook/widgets/text_fields/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  BuildContext? dialogueContext;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: context.height() * 0.35,
              width: context.width(),
              child: Stack(children: <Widget>[
                Image.asset(
                  AppImages.signInCover,
                  width: context.width(),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Ionicons.arrow_back,
                          color: AppColors.appWhiteColor,
                          size: 30.sp,
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      PrimaryTextWidget(
                        text: AppText.signinText,
                        fontSize: 35.sp,
                        fontColor: AppColors.appWhiteColor,
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
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                        controller: _emailController,
                        prefixIcon: Ionicons.mail_outline,
                        label: AppText.emailText,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter email address";
                          } else if (RegExp(
                                      r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(val) ==
                              false) {
                            return "Please enter valid email address";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    PasswordTextFieldWidget(
                      controller: _passwordController,
                      prefixIcon: Ionicons.lock_closed_outline,
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
            // Padding(
            //   padding:
            //       EdgeInsets.only(left: 15.w, right: 18.w, bottom: 20.h),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).push(MaterialPageRoute(
            //               builder: (builder) => ForgetPasswordScreen()));
            //         },
            //         child: PrimaryTextWidget(
            //           text: AppText.forgetPassword,
            //           fontSize: 14.sp,
            //           fontColor: Colors.black,
            //           fontFamily: AppFonts.openSansLight,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
              child: PrimaryButtonWidget(
                  width: context.width(),
                  height: 50.h,
                  caption: AppText.signinText,
                  onPressed: () async {
                    if (formGlobalKey.currentState!.validate()) {}
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
              child: Row(children: <Widget>[
                const Expanded(
                    child: Divider(
                  color: Colors.black,
                )),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: PrimaryTextWidget(
                    text: AppText.orContinueWith,
                    fontSize: 14.sp,
                    fontColor: Colors.black,
                    fontFamily: AppFonts.openSansLight,
                  ),
                ),
                const Expanded(
                    child: Divider(
                  color: Colors.black,
                )),
              ]),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: const Icon(
                    Ionicons.logo_facebook,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: const Icon(
                    Ionicons.logo_google,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryTextWidget(
                    text: AppText.dontHaveAccount,
                    fontSize: 14.sp,
                    fontFamily: AppFonts.openSansLight,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: PrimaryTextWidget(
                      text: AppText.signupText,
                      fontSize: 14.sp,
                      fontColor: Colors.black,
                      fontFamily: AppFonts.robotoBold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
