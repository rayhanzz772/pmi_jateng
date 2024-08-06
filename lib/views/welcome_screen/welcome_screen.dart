import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/sign_in/sign_in.dart';
import 'package:pmi_jateng/views/sign_up/sign_up.dart';

class MenuSelectScreen extends StatefulWidget {
  @override
  _MenuSelectScreenState createState() => _MenuSelectScreenState();
}

class _MenuSelectScreenState extends State<MenuSelectScreen> {
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(offset: 0),
                child: Container(
                  height: hp * 0.39,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                ),
              ),
              ClipPath(
                clipper: WaveClipper(offset: 0.5),
                child: Container(
                  height: hp * 0.45,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.6),
                  ),
                ),
              ),
              ClipPath(
                clipper: WaveClipperReversedFromRight(offset: 0.57),
                child: Container(
                  height: hp * 0.479,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.2),
                  ),
                ),
              ),
              Container(
                height: hp * 0.42,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PUSDIKLAT',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: wp * 0.1,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryWhite),
                      ),
                      Text(
                        'Provinsi Jawa Tengah',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: wp * 0.05,
                            fontWeight: FontWeight.w100,
                            color: kPrimaryWhite),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: hp * 0.10,
                              width: wp * 0.27,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/logo.png'),
                                    fit: BoxFit.cover),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Palang',
                                style: TextStyle(
                                  color: kPrimaryWhite,
                                  fontSize: wp * 0.045,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Merah',
                                style: TextStyle(
                                  color: kPrimaryWhite,
                                  fontSize: wp * 0.045,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'Indonesia',
                                style: TextStyle(
                                  color: kPrimaryWhite,
                                  fontSize: wp * 0.045,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  right: 40, left: 40, top: 10, bottom: hp * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 9),
                    // child: Text(
                    //   'Selamat Datang,',
                    //   style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 18),
                    // ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: wp,
                        height: hp * 0.063,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: wp * 0.04,
                                fontWeight: FontWeight.w700,
                                color: kPrimaryWhite),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sudah punya akun?',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: wp * 0.035,
                                  fontWeight: FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()),
                                );
                              },
                              child: Text(
                                ' Sign In',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: wp * 0.035,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double offset;

  WaveClipper({this.offset = 0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);

    final firstControlPoint = Offset(size.width / 4, size.height - 30 - offset);
    final firstEndPoint = Offset(size.width / 2, size.height - 20 + offset);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint =
        Offset(size.width * 3 / 4, size.height - 10 - offset);
    final secondEndPoint = Offset(size.width, size.height - 50 + offset);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipperReversedFromRight extends CustomClipper<Path> {
  final double offset;

  WaveClipperReversedFromRight({this.offset = 0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);

    final firstControlPoint =
        Offset(size.width * 3 / 4, size.height - 30 - offset);
    final firstEndPoint = Offset(size.width / 2, size.height - 20 + offset);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint =
        Offset(size.width / 4, size.height - 10 - offset);
    final secondEndPoint = Offset(0, size.height - 50 + offset);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
