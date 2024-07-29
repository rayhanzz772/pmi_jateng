import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmi_jateng/views/room_screen/room_screen.dart';
import 'package:pmi_jateng/views/test_untuk_fetch/test.dart';
import 'package:pmi_jateng/views/splash_screen/screen/splash_screen.dart';
import 'package:pmi_jateng/views/sign_up/sign_up.dart';
import 'package:pmi_jateng/views/sign_in/sign_in.dart';
import 'package:pmi_jateng/views/home_screen/home_screen.dart';
import 'package:pmi_jateng/views/bottom_bar/bottom_bar.dart';
import 'package:pmi_jateng/views/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Periksa status login
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: isLoggedIn ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/welcome_screen', page: () => MenuSelectScreen()),
        GetPage(name: '/sign_in', page: () => SignInScreen()),
        GetPage(name: '/sign_up', page: () => SignUpScreen()),
        GetPage(name: '/menu_select', page: () => MenuSelectScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/bottom_bar', page: () => BottomBar()),
        GetPage(name: '/test_api', page: () => TestApiScreen()),
        GetPage(
          name: '/room_screen',
          page: () => RoomScreen(id: Get.arguments as int),
        ),
      ],
    );
  }
}
