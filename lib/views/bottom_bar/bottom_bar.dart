import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/room_screen/room_screen.dart';
import 'package:pmi_jateng/blocs/bottom_bar/bottom_bar_bloc.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late PageController _pageController;
  int _bottomNavIndex = 0;
  late List<Widget> pages;
  late List<IconData> iconList;

  @override
  void initState() {
    super.initState();
    _pageController = initializePageController(_bottomNavIndex);
    pages = initializePages();
    iconList = initializeIconList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(
        context: context,
        bottomNavIndex: _bottomNavIndex,
        pageController: _pageController,
        setStateCallback: (callback) => setState(callback),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RoomScreen()),
            );
          },
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          ),
          child: Icon(
            Icons.add,
            color: kPrimaryWhite,
          ),
          heroTag: 'uniqueHeroTag',
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
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            setState(() {
              _pageController.jumpToPage(index);
              _bottomNavIndex = index;
            });
          },
        ),
      ),
    );
  }
}
