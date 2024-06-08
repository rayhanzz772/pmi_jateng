import 'dart:async';
import 'package:flutter/material.dart';

class SplashBloc {
  void initDelay(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/sign_in');
    });
  }
}
