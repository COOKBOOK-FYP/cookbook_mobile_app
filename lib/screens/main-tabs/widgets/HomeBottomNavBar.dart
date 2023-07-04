// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:io';

import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

GNav HomeBottomNavBar(BuildContext context, {void Function(int)? onTabChange}) {
  return GNav(
      selectedIndex: 0,
      onTabChange: onTabChange,
      haptic: true, // haptic feedback
      backgroundColor: AppColors.primaryColor,
      tabBorderRadius: 30,
      duration: const Duration(milliseconds: 400),
      gap: 8, // the tab button gap between icon and text
      color: AppColors.appWhiteColor, // unselected icon color
      activeColor: AppColors.primaryColor, // selected icon and text color
      iconSize: 24, // tab button icon size // selected tab background color
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 8), // navigation bar padding
      tabMargin:
          EdgeInsets.symmetric(vertical: Platform.isIOS ? 8 : 5, horizontal: 5),
      tabs: [
        GButton(
          icon: Ionicons.home_outline,
          iconSize: 22,
          text: AppText.homeText,
          backgroundColor: AppColors.appWhiteColor,
        ),
        // GButton(
        //   icon: Ionicons.search_outline,
        //   text: AppText.tab2,
        //   iconSize: 22,
        //   backgroundColor: AppColors.appWhiteColor,
        // ),
        // GButton(
        //   icon: Ionicons.cart_outline,
        //   text: AppText.tab3,
        //   iconSize: 22,
        //   backgroundColor: AppColors.appWhiteColor,
        // ),
        // GButton(
        //   icon: Ionicons.heart_outline,
        //   text: AppText.tab4,
        //   iconSize: 22,
        //   backgroundColor: AppColors.appWhiteColor,
        // ),
        GButton(
          icon: Ionicons.person_outline,
          text: AppText.accountText,
          iconSize: 22,
          backgroundColor: AppColors.appWhiteColor,
        ),
      ]);
}
