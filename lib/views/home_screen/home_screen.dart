// home_screen.dart
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
            Container(
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
                    padding: EdgeInsets.only(top: 45, left: 20),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Hallo, Rayhan',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: kPrimaryWhite),
                              ),
                              Text(
                                'Apakah anda ingin melaporkan sesuatu hari ini',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
