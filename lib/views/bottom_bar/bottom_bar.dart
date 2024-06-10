import 'package:nuraga_app/utils/color/constant.dart';
import 'package:nuraga_app/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:nuraga_app/views/lapor_screen/lapor_screen.dart';
import 'package:nuraga_app/views/notification_screen/notification_screen.dart';
import 'package:nuraga_app/views/profile_screen/profile_screen.dart';
import 'package:nuraga_app/views/search_screen/search_screen.dart';

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
      LaporScreen(),
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
    return WillPopScope(
      onWillPop: () async {
        if (_bottomNavIndex != 0) {
          _pageController.jumpToPage(0);
          setState(() {
            _bottomNavIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: pages,
          onPageChanged: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          },
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          activeColor: kPrimaryYellow,
          splashColor: kPrimaryGrey,
          inactiveColor: kPrimaryWhite,
          backgroundColor: kPrimaryColor,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.defaultEdge,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
