// home_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nuraga_app/utils/color/constant.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      body: Container(
        child: Column(
          children: [
            TopContainer(),
            BottomContainer(),
          ],
        ),
      ),
    );
  }
}

// ini untuk bagian atas pada homescreen
class TopContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_home.png'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(35),
              bottomLeft: Radius.circular(35))),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            padding: EdgeInsets.only(top: 45, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo, Rayhan',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryWhite),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Apakah anda ingin melaporkan sesuatu hari ini',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: kPrimaryWhite),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.14,
                  height: MediaQuery.of(context).size.height * 0.23,
                  child: Align(
                    alignment: Alignment.topLeft, // Align image to top start
                    child: Container(
                      width: 46, // Custom width for the circle
                      height: 46,
                      // Ensure it's a square for a perfect circle
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kPrimaryWhite, width: 3),
                        image: DecorationImage(
                          image: AssetImage('assets/images/image_profile.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            padding: EdgeInsets.only(right: 50, left: 50),
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Color(0xFFC7C7C7),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        color: kPrimaryYellow,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Laporan :',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000)),
                              ),
                              Text(
                                '5',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              'assets/images/statistic.png',
                            ),
                            fit: BoxFit.cover,
                          )),
                        ),
                      ],
                    ),
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

// ini untuk bagian bawah homescreen
class BottomContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
      height: MediaQuery.of(context).size.height * 0.57,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apa yang sedang terjadi ?',
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.17,
              decoration: BoxDecoration(
                color: kPrimaryYellow,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Shadow color with opacity
                    spreadRadius: 2, // Spread radius
                    blurRadius: 4, // Blur radius
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 12, left: 14, bottom: 12),
                    decoration: BoxDecoration(
                        color: kPrimaryWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/buat_laporan.png'),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buat Laporan',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: black),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Laporkan kepada kami apabila anda menemukan ODGJ',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 19,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.17,
              decoration: BoxDecoration(
                color: kPrimaryYellow,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Shadow color with opacity
                    spreadRadius: 2, // Spread radius
                    blurRadius: 4, // Blur radius
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: kPrimaryWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/riwayat.png'),
                        fit: BoxFit.contain,
                      )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riwayat',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: black),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Kumpulan laporan yang pernah anda ajukan',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
