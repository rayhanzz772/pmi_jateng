import 'package:flutter/material.dart';
import 'package:nuraga_app/blocs/authentication_bloc.dart';
import 'package:nuraga_app/constant.dart';
import 'package:nuraga_app/views/sign_in.dart';
import 'package:nuraga_app/views/sign_up.dart';
import 'package:nuraga_app/utils/half_circle_clipper.dart';

class MenuSelectScreen extends StatefulWidget {
  @override
  _MenuSelectScreenState createState() => _MenuSelectScreenState();
}

class _MenuSelectScreenState extends State<MenuSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarywhite,
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
                                color: kPrimarywhite,
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
                                  color: kPrimarywhite),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
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
                            color: kPrimarywhite),
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
            )
          ],
        ),
      ),
    );
  }
}
