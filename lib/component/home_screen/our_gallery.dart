import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class OurGallery extends StatefulWidget {
  @override
  _OurGalleryState createState() => _OurGalleryState();
}

class _OurGalleryState extends State<OurGallery> {
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Container(
      height: hp * 0.43,
      padding: EdgeInsets.only(top: hp * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 2,
                    width: wp * 0.15,
                    decoration: BoxDecoration(color: kPrimaryMaroon),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Our Gallery',
                      style: TextStyle(
                        fontFamily: 'Judson',
                        fontSize: wp * 0.06,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 2,
                width: wp * 0.475,
                decoration: BoxDecoration(color: kPrimaryMaroon),
              ),
            ],
          ),
          SizedBox(height: hp * 0.01),
          Container(
            height: hp * 0.35,
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: wp * 0.336,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/kamar_2.png'),
                    fit: BoxFit.cover,
                  )),
                ),
                SizedBox(width: 10),
                Container(
                  width: wp * 0.58,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  height: hp * 0.14,
                                  width: wp * 0.27,
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/kamar.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  height: hp * 0.14,
                                  width: wp * 0.27,
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/room_1.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: hp * 0.28,
                              width: wp * 0.27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage('assets/images/room_3.jpeg'),
                                fit: BoxFit.cover,
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          'Pusdiklat PMI Jateng',
                          style: TextStyle(
                            fontFamily: 'Judson',
                            fontSize: wp * 0.06,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
