import 'package:flutter/material.dart';
import 'package:pmi_jateng/blocs/splash_screen/splash_bloc.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    _bloc.initDelay(context);
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: kPrimaryWhite,
        child: Center(
          child: Container(
              height: hp * 0.22,
              width: wp * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/620x480.png'),
                    fit: BoxFit.cover),
              )),
        ),
      ),
    );
  }
}
