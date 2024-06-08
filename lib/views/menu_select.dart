import 'package:flutter/material.dart';
import 'package:nuraga_app/constant.dart';
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
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.063,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi yang diambil ketika tombol ditekan
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
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        Text(' Sign In'),
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
