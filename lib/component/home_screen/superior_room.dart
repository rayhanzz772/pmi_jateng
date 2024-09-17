import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class SuperiorRoom extends StatefulWidget {
  @override
  _SuperiorRoomState createState() => _SuperiorRoomState();
}

class _SuperiorRoomState extends State<SuperiorRoom> {
  int _current = 0;
  final List<String> imgList = [
    'assets/images/kamar_2.png',
    'assets/images/kamar.jpeg',
    'assets/images/our_room.jpg',
  ];
  final List<String> textList = [
    "Ruangan ini merupakan perpaduan sempurna antara kenyamanan dan gaya, menawarkan suasana yang tenang dan mengundang sehingga membuat Anda merasa seperti di rumah sendiri.",
    "Desain ruangan ini benar-benar luar biasa, setiap detail dipertimbangkan dengan cermat untuk menciptakan ruang yang memancarkan keanggunan dan kehangatan.",
    "Ruangan ini menonjol dengan gaya yang tak tertandingi dan perhatian pada detail, menjadi tempat di mana kemewahan bertemu dengan kenyamanan, menjadikannya tempat istirahat yang ideal.",
  ];

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: hp * 0.455,
          child: Row(
            children: [
              Container(
                width: wp * 0.4,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: kPrimaryMaroon, width: 2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: hp * 0.13,
                      width: wp,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/kamar_2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: hp * 0.13,
                      width: wp,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Award',
                                style: TextStyle(
                                  fontFamily: 'Judson',
                                  fontSize: wp * 0.06,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'winning',
                                style: TextStyle(
                                  fontFamily: 'Freehand',
                                  fontSize: wp * 0.06,
                                  color: kPrimaryMaroon,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Text(
                              'style and',
                              style: TextStyle(
                                fontFamily: 'Judson',
                                fontSize: wp * 0.06,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'comfort',
                              style: TextStyle(
                                fontFamily: 'Judson',
                                fontSize: wp * 0.06,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: hp * 0.12,
                      width: wp,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/kamar.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: wp * 0.06,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: kPrimaryMaroon, width: 2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: hp * 0.01),
                            width: 2,
                            height: hp * 0.09,
                            color: kPrimaryMaroon,
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              'ROOMS',
                              style: TextStyle(
                                color: kPrimaryMaroon,
                                fontSize: wp * 0.03,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: hp * 0.01),
                            width: 2,
                            height: hp * 0.283,
                            color: kPrimaryMaroon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: wp * 0.54,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: kPrimaryMaroon, width: 2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OUR',
                      style: TextStyle(
                        fontFamily: 'Judson',
                        fontSize: wp * 0.06,
                        color: kPrimaryMaroon,
                      ),
                    ),
                    Text(
                      'ROOM',
                      style: TextStyle(
                        fontFamily: 'Judson',
                        fontSize: wp * 0.06,
                        color: kPrimaryMaroon,
                      ),
                    ),
                    SizedBox(height: 15),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: hp * 0.2,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 2.0,
                        autoPlayInterval: Duration(seconds: 5),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: imgList.map((item) {
                        return Container(
                          child: Center(
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              width: wp,
                              height: hp * 0.2,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        textList[_current],
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: wp * 0.03,
                          color: kPrimaryBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
