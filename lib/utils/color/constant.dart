import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF1F319D);
const kPrimaryYellow = Color(0xFFFDC500);
const kPrimarywhite = Color(0xFFFFFFFF);
const kPrimarygrey = Color(0xFFF4F4F4);
const kPrimaryLightColor = Color.fromRGBO(237, 237, 237, 1);
const kBackgroundColor = Color.fromRGBO(255, 240, 239, 239);
const black = Color.fromRGBO(44, 44, 44, 1);
const double defaultPadding = 16.0;

class AppBoxShadows {
  static final boxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 1,
    offset: Offset(0.9, 0.9),
  );

  // Jika Anda membutuhkan box shadow lain, tambahkan di sini
}
