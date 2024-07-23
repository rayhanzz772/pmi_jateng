import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc {
  Future<void> initDelay(BuildContext context) async {
    // Delay for splash screen effect
    await Future.delayed(Duration(seconds: 3));

    // Periksa status login
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Navigasi berdasarkan status login
    if (isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/menu_select');
    }
  }
}
