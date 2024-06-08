import 'package:flutter/material.dart';
import 'package:nuraga_app/views/splash_screen.dart';
import 'package:nuraga_app/views/sign_up.dart';
import 'package:nuraga_app/views/sign_in.dart';
import 'package:nuraga_app/views/menu_select.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Splash Screen with BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/sign_in': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/menu_select': (context) => MenuSelectScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
