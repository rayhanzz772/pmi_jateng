import 'package:flutter/material.dart';
import 'package:pmi_jateng/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/sign_in/sign_in.dart';
import 'package:pmi_jateng/views/sign_up/sign_up.dart';
import 'package:pmi_jateng/utils/design/half_circle_clipper.dart';

class MenuSelectScreen extends StatefulWidget {
  @override
  _MenuSelectScreenState createState() => _MenuSelectScreenState();
}

class _MenuSelectScreenState extends State<MenuSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      body: Container(
        child: Column(
          children: [
            Container(
              child: ClipPath(
                clipper: HalfCircleClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        'NURAGA',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 62,
                            fontWeight: FontWeight.w800,
                            color: kPrimaryYellow),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              textAlign: TextAlign.center,
                              'Layanan Pengaduan Online Rakyat',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: kPrimaryWhite,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              textAlign: TextAlign.center,
                              'Sampaikan laporan Anda bila terjadi sesuatu yang meresahkan.',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: kPrimaryWhite),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  padding: EdgeInsets.only(right: 40, left: 40, top: 180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.063,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryYellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: kPrimaryWhite),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
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
                                  fontSize: 12,
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
                                    fontSize: 12,
                                    color: kPrimaryYellow,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    left: -60, // Menggeser ke kiri sejauh 50
                    top: MediaQuery.of(context).size.height * 0.06 - 40,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
