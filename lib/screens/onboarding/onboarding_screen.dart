// ignore_for_file: prefer_const_constructors

import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_textstyle.dart';
import 'package:cookbook/global/utils/secure_storage.dart';
import 'package:cookbook/models/onboarding_model.dart';
import 'package:cookbook/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    newUser();
    super.initState();
  }

  newUser() async {
    await UserSecureStorage.setNewUser('new');
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50.r),
        ),
        color: _currentPage == index
            ? AppColors.primaryColor
            : Colors.grey.shade600,
      ),
      margin: EdgeInsets.only(right: 5.w),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20.sp : 10.sp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          contents[_currentPage].image,
          height: context.height(),
          width: context.width(),
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          backgroundColor: transparentColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (value) =>
                        setState(() => _currentPage = value),
                    itemCount: contents.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.all(20.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.onboardingTitleTextStyle,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (int index) => _buildDots(
                            index: index,
                          ),
                        ),
                      ),
                      _currentPage + 1 == contents.length
                          ? Padding(
                              padding: EdgeInsets.all(20.w),
                              child: PrimaryButtonWidget(
                                  width: context.width(),
                                  height: 50,
                                  caption: 'Getting Started',
                                  onPressed: () {
                                    // Navigate to Login Screen
                                  }),
                            )
                          : Padding(
                              padding: EdgeInsets.all(20.w),
                              child: PrimaryButtonWidget(
                                  width: context.width(),
                                  height: 50.h,
                                  caption: 'Next',
                                  onPressed: () {
                                    _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                    );
                                  }),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
