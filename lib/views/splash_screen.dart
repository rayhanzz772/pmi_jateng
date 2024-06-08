import 'package:flutter/material.dart';
import 'package:nuraga_app/blocs/splash_bloc.dart';
import 'package:nuraga_app/constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SplashBloc();
    _bloc.initDelay(
        context); // Memanggil metode initDelay untuk menunda navigasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF1F319D),
        child: Center(
          child: Text(
            'NURAGA',
            style: TextStyle(
              color: kPrimaryYellow,
              fontSize: 50.0,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
