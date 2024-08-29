import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/views/available/available_room.dart';
import 'package:pmi_jateng/views/booking/booking_regular.dart';
import 'package:pmi_jateng/views/history/detail/history_detail.dart';
import 'package:pmi_jateng/views/history/history_screen.dart';
import 'package:pmi_jateng/views/profile_screen/information.dart';
import 'package:pmi_jateng/views/room_screen/room_screen_package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmi_jateng/views/room_screen/room_screen_regular.dart';
import 'package:pmi_jateng/views/splash_screen/splash_screen.dart';
import 'package:pmi_jateng/views/sign_up/sign_up.dart';
import 'package:pmi_jateng/views/sign_in/sign_in.dart';
import 'package:pmi_jateng/views/home_screen/home_screen.dart';
import 'package:pmi_jateng/views/bottom_bar/bottom_bar.dart';
import 'package:pmi_jateng/service/auth_control.dart';
import 'package:pmi_jateng/views/profile_screen/profile_screen.dart';
import 'package:pmi_jateng/views/profile_screen/edit_profile.dart';
import 'package:pmi_jateng/views/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Periksa status login
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthControl());
      }),
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/welcome_screen', page: () => MenuSelectScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/sign_up', page: () => SignUpScreen()),
        GetPage(name: '/sign_in', page: () => SignInScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/bottom_bar', page: () => BottomBar()),
        GetPage(name: '/edit_profile', page: () => EditProfile()),
        GetPage(name: '/history', page: () => HistoryScreen()),
        GetPage(
            name: '/available',
            page: () => AvailableScreen(data: Get.arguments['data'])),
        GetPage(
          name: '/room_screen_regular',
          page: () => RoomScreenRegular(id: Get.arguments as int),
        ),
        GetPage(
          name: '/room_screen_package',
          page: () => RoomScreenPackage(id: Get.arguments as int),
        ),
        GetPage(
          name: '/history_detail',
          page: () => HistoryDetail(
              id: Get.arguments as int, user_email: Get.arguments as String),
        ),
      ],
    );
  }
}
