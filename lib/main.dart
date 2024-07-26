import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmi_jateng/room_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmi_jateng/firebase_options.dart';
import 'package:pmi_jateng/views/notification_screen/notification_screen.dart';
import 'package:pmi_jateng/views/splash_screen/screen/splash_screen.dart';
import 'package:pmi_jateng/views/sign_up/sign_up.dart';
import 'package:pmi_jateng/views/sign_in/sign_in.dart';
import 'package:pmi_jateng/views/home_screen/home_screen.dart';
import 'package:pmi_jateng/views/bottom_bar/bottom_bar.dart';
import 'package:pmi_jateng/views/welcome_screen/welcome_screen.dart';
import 'package:pmi_jateng/room_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: isLoggedIn ? '/home' : '/',
      routes: {
        '/': (context) => RoomTypeList(),
        '/sign_in': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/menu_select': (context) => MenuSelectScreen(),
        '/home': (context) => HomeScreen(),
        '/bottom_bar': (context) => BottomBar(),
      },
    );
  }
}
