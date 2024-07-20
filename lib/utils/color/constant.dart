import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFDA251D);
const kPrimaryMaroon = Color(0xFFC13333);
const kPrimaryFontColor = Color(0xFF8D0000);
const kPrimaryBlack = Color(0xFF000000);
const kPrimaryYellow = Color(0xFFFDC500);
const kPrimaryWhite = Color(0xFFFFFFFF);
const kPrimaryGrey = Color(0xFFF0EFEF);
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
