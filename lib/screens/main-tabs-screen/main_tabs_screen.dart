// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_import

import 'dart:io';

import 'package:cookbook/constants/app_colors.dart';
import 'package:cookbook/screens/account/account_screen.dart';
import 'package:cookbook/screens/main-tabs-screen/widgets/FadeIndexedStack.dart';
import 'package:cookbook/screens/main-tabs-screen/widgets/HomeBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({Key? key}) : super(key: key);

  @override
  _MainTabsScreenState createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int tabindex = 0;
  static List<Widget> homepageTabs = <Widget>[
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
    Container(color: Colors.cyan),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              duration: const Duration(milliseconds: 500),
              child: FadeIndexedStack(
                index: tabindex,
                children: homepageTabs,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                alignment: Alignment.center,
                height: Platform.isAndroid ? 55 : 60,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: HomeBottomNavBar(context, onTabChange: (index) {
                  if (tabindex != index) {
                    setState(() {
                      tabindex = index;
                    });
                    //Home Page
                    if (tabindex == 0) {}

                    //Search Page
                    if (tabindex == 1) {}

                    //Cart Page
                    if (tabindex == 2) {}

                    //WishList Page
                    if (tabindex == 3) {}

                    //Account Page
                    if (index == 4) {}
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
