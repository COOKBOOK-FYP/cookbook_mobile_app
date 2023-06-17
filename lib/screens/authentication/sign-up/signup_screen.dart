// // ignore_for_file: unnecessary_string_interpolations

// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:justbuyeight/blocs/authentication/registration/registration_cubit.dart';
// import 'package:justbuyeight/blocs/authentication/validate_email/validate_email_cubit.dart';
// import 'package:justbuyeight/constants/app_colors.dart';
// import 'package:justbuyeight/constants/app_fonts.dart';
// import 'package:justbuyeight/constants/app_images.dart';
// import 'package:justbuyeight/constants/app_texts.dart';
// import 'package:justbuyeight/models/authentication/user_model.dart';
// import 'package:justbuyeight/screens/authentication/otp_verification_screen.dart';
// import 'package:justbuyeight/utils/SnackBars.dart';
// import 'package:justbuyeight/widgets/components/buttons/primary_button_widget.dart';
// import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
// import 'package:justbuyeight/widgets/components/text_fields/mobile_number_text_field.dart';
// import 'package:justbuyeight/widgets/components/text_fields/password_text_field_widget.dart';
// import 'package:justbuyeight/widgets/components/text_fields/text_field_widget.dart';
// import 'package:nb_utils/nb_utils.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final formGlobalKey = GlobalKey<FormState>();

//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();

//   late ValidateEmailCubit validateEmailCubit;
//   late RegistrationCubit registrationCubit;

//   BuildContext? dialogueContext;

//   initCubit() {
//     validateEmailCubit = context.read<ValidateEmailCubit>();
//     registrationCubit = context.read<RegistrationCubit>();
//   }

//   @override
//   void initState() {
//     initCubit();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<ValidateEmailCubit, ValidateEmailState>(
//           listener: (context, state) async {
//             if (state is ValidateEmailLoading) {
//               showDialog(
//                   context: context,
//                   barrierDismissible: false,
//                   builder: (ctx) {
//                     dialogueContext = ctx;
//                     return Container(
//                       color: Colors.transparent,
//                       child: Center(
//                         child: SpinKitThreeBounce(
//                           color: AppColors.primaryColor,
//                           size: 30.0,
//                         ),
//                       ),
//                     );
//                   });
//             } else if (state is ValidateEmailSuccessfuly) {
//               var registrationMap = {
//                 "f_name": "${_firstNameController.text.trim()}",
//                 "l_name": "${_lastNameController.text.trim()}",
//                 "phone": "${_phoneNumberController.text.trim()}",
//                 "email": "${_emailController.text.trim()}",
//                 "password": "${_passwordController.text.trim()}",
//               };
//               await registrationCubit.userRegistration(registrationMap);
//             } else if (state is ValidateEmailInternetError) {
//               SnackBars.Danger(context, AppText.internetError);
//               Navigator.of(dialogueContext!).pop();
//             } else if (state is ValidateEmailAlreadyExist) {
//               SnackBars.Danger(context, AppText.emailExist);
//               Navigator.of(dialogueContext!).pop();
//             } else if (state is ValidateEmailFailed) {
//               SnackBars.Danger(context, AppText.registrationFailed);
//               Navigator.of(dialogueContext!).pop();
//             } else if (state is ValidateEmailTimeOut) {
//               SnackBars.Danger(context, AppText.timeOut);
//               Navigator.of(dialogueContext!).pop();
//             }
//           },
//         ),
//         BlocListener<RegistrationCubit, RegistrationState>(
//           listener: (context, state) {
//             if (state is RegistrationSuccessfull) {
//               UserModel userModel = UserModel();

//               userModel.setFirstName = _firstNameController.text.trim();
//               userModel.setLastName = _lastNameController.text.trim();
//               userModel.setEmail = _emailController.text.trim();
//               userModel.setPassword = _passwordController.text.trim();
//               userModel.setPhoneNumber = _phoneNumberController.text.trim();

//               Navigator.of(dialogueContext!).pop();

//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (builder) => OtpVerificationScreen(
//                         email: _emailController.text.trim(),
//                         tapFrom: 'signupScreen',
//                       )));
//             } else if (state is RegistrationAlreadyExist) {
//               SnackBars.Success(context, "User account already exist");
//               Navigator.of(dialogueContext!).pop();
//             } else if (state is RegistrationInternetError) {
//               SnackBars.Danger(context, "Internet connection failed");
//               Navigator.of(dialogueContext!).pop();
//             } else if (state is RegistrationFailed) {
//               SnackBars.Danger(context, "User account creation failed");
//               Navigator.of(dialogueContext!).pop();
//             } else if (state is RegistrationTimeout) {
//               SnackBars.Danger(context, "Request timeout");
//               Navigator.of(dialogueContext!).pop();
//             }
//           },
//         ),
//       ],
//       child: GestureDetector(
//         onTap: () {
//           FocusScopeNode currentFocus = FocusScope.of(context);
//           if (!currentFocus.hasPrimaryFocus) {
//             return currentFocus.unfocus();
//           }
//         },
//         child: Scaffold(
//           body: ListView(
//             children: [
//               SizedBox(
//                 height: 180.h,
//                 width: context.width(),
//                 child: Stack(children: <Widget>[
//                   Image.asset(
//                     ImageAssets.signUpCover,
//                     height: 200.h,
//                     width: context.width(),
//                     fit: BoxFit.cover,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 15.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Icon(
//                             Ionicons.chevron_back,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 50.h,
//                         ),
//                         PrimaryTextWidget(
//                           text: AppText.signUp,
//                           fontSize: 25.sp,
//                           fontColor: Colors.white,
//                           fontFamily: AppFonts.openSansBold,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               Form(
//                 key: formGlobalKey,
//                 child: Padding(
//                   padding:
//                       EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
//                   child: Column(
//                     children: [
//                       TextFieldWidget(
//                         controller: _firstNameController,
//                         prefixIcon: Ionicons.person_outline,
//                         label: AppText.firstName,
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return "Please enter first name";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       TextFieldWidget(
//                         controller: _lastNameController,
//                         prefixIcon: Ionicons.person_outline,
//                         label: AppText.lastName,
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return "Please enter last name";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       TextFieldWidget(
//                         controller: _emailController,
//                         prefixIcon: Ionicons.mail_outline,
//                         label: AppText.email,
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return "Please enter email address";
//                           } else if (RegExp(
//                                       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                                   .hasMatch(val) ==
//                               false) {
//                             return "Please enter valid email address";
//                           } else if (EmailValidator.validate(val) == false) {
//                             return "Please enter valid email address";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       MobileNumberTextField(
//                         controller: _phoneNumberController,
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return "Please enter phone number";
//                           } else if (val.length > 11) {
//                             return "Password length should be equal to 11";
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       PasswordTextFieldWidget(
//                         controller: _passwordController,
//                         prefixIcon: Ionicons.lock_closed_outline,
//                         label: AppText.password,
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return "Please enter password";
//                           } else if (val.length < 8) {
//                             return "Password length should be greater than 8";
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
//                 child: PrimaryButtonWidget(
//                     width: context.width(),
//                     height: 50.h,
//                     caption: AppText.signUp,
//                     onPressed: () async {
//                       if (formGlobalKey.currentState!.validate()) {
//                         await validateEmailCubit
//                             .validateEmail(_emailController.text.trim());
//                       }
//                     }),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
//                 child: Row(children: <Widget>[
//                   const Expanded(
//                       child: Divider(
//                     color: Colors.black,
//                   )),
//                   Padding(
//                     padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                     child: PrimaryTextWidget(
//                       text: AppText.continueWith,
//                       fontSize: 14.sp,
//                       fontColor: Colors.black,
//                       fontFamily: AppFonts.openSansLight,
//                     ),
//                   ),
//                   const Expanded(
//                       child: Divider(
//                     color: Colors.black,
//                   )),
//                 ]),
//               ),
//               SizedBox(height: 20.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8.r)),
//                     child: const Icon(
//                       Ionicons.logo_facebook,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8.r)),
//                     child: const Icon(
//                       Ionicons.logo_google,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8.r)),
//                     child: const Icon(
//                       Ionicons.logo_apple,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     PrimaryTextWidget(
//                       text: AppText.alreadyHaveAnAccount,
//                       fontSize: 14.sp,
//                       fontFamily: AppFonts.openSansLight,
//                     ),
//                     SizedBox(
//                       width: 5.w,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: PrimaryTextWidget(
//                         text: AppText.signInText,
//                         fontSize: 14.sp,
//                         fontColor: Colors.black,
//                         fontFamily: AppFonts.robotoBold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
