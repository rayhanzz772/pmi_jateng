import 'package:nuraga_app/utils/color/constant.dart';
import 'package:nuraga_app/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:nuraga_app/views/lapor_screen/lapor_screen.dart';
import 'package:nuraga_app/views/notification_screen/notification_screen.dart';
import 'package:nuraga_app/views/profile_screen/profile_screen.dart';
import 'package:nuraga_app/views/search_screen/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late PageController _pageController;
  int _bottomNavIndex = 0;
  late List<Widget> pages;

  final List<IconData> iconList = [
    Icons.home_filled,
    Icons.search,
    Icons.add,
    Icons.notifications,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _bottomNavIndex);
    pages = [
      HomeScreen(),
      SearchScreen(),
      Container(), // Placeholder for "Lapor" screen
      NotificationScreen(),
      ProfileScreen()
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pageController.jumpToPage(2); // Jump to the "Lapor" screen
          setState(() {
            _bottomNavIndex = 2; // Update the bottom nav index
          });
        },
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        child: Icon(
          Icons.add,
          color: kPrimaryWhite,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeColor: kPrimaryYellow,
        splashColor: kPrimaryGrey,
        inactiveColor: kPrimaryWhite,
        backgroundColor: kPrimaryColor,
        leftCornerRadius: 18,
        rightCornerRadius: 18,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
