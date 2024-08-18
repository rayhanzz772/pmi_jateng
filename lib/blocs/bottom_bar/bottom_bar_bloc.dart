import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/home_screen/home_screen.dart';
import 'package:pmi_jateng/views/booking/booking_regular.dart';
import 'package:pmi_jateng/views/notification_screen/notification_screen.dart';
import 'package:pmi_jateng/views/profile_screen/profile_screen.dart';

List<Widget> initializePages() {
  return [
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
}

PageController initializePageController(int initialPage) {
  return PageController(initialPage: initialPage);
}

List<IconData> initializeIconList() {
  return [
    Icons.home_filled,
    Icons.search,
    Icons.notifications,
    Icons.person,
  ];
}

Future<bool> onWillPop({
  required BuildContext context,
  required int bottomNavIndex,
  required PageController pageController,
  required Function setStateCallback,
}) async {
  if (bottomNavIndex != 0) {
    setStateCallback(() {
      pageController.jumpToPage(0);
      bottomNavIndex = 0;
    });
    return Future.value(false);
  } else {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Keluar',
              style:
                  TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.bold),
            ),
            content: Text('Anda yakin ingin keluar?'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                          decoration: BoxDecoration(
                            color:
                                kPrimaryColor, // Background color with opacity
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: kPrimaryColor),
                          ),
                          child: Text(
                            'Tidak',
                            style: TextStyle(
                                color: kPrimaryWhite, fontFamily: 'poppins'),
                          )),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () => SystemNavigator.pop(),
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 27),
                          decoration: BoxDecoration(
                            color:
                                kPrimaryColor, // Background color with opacity
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: kPrimaryColor),
                          ),
                          child: Text(
                            'Iya',
                            style: TextStyle(
                                color: kPrimaryWhite, fontFamily: 'poppins'),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ) ??
        false;
  }
}
