import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(20),
      height: hp * 0.39,
      width: wp,
      decoration: BoxDecoration(color: kPrimaryBlack),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PUSDIKLAT',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: kPrimaryColor,
                          fontSize: wp * 0.03,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Jawa Tengah',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: kPrimaryWhite,
                          fontSize: wp * 0.022,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                SizedBox(width: 4),
                Container(
                  height: hp * 0.03,
                  width: wp * 0.005,
                  decoration: BoxDecoration(color: kPrimaryWhite),
                ),
                SizedBox(width: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: hp * 0.04,
                        width: wp * 0.07,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover),
                        )),
                    SizedBox(width: 7),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Palang',
                          style: TextStyle(
                            color: kPrimaryWhite,
                            fontSize: wp * 0.018,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Merah',
                          style: TextStyle(
                            color: kPrimaryWhite,
                            fontSize: wp * 0.018,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Indonesia',
                          style: TextStyle(
                            color: kPrimaryWhite,
                            fontSize: wp * 0.018,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Hubungi Kami',
            style: TextStyle(
                fontSize: wp * 0.035,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: kPrimaryWhite),
          ),
          Text(
            'Pusdiklat PMI Jawa Tengah',
            style: TextStyle(
                fontSize: wp * 0.035,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: kPrimaryWhite),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.location_on),
                      iconSize: hp * 0.025,
                      color: kPrimaryMaroon,
                      onPressed: () {},
                    ),
                    Text(
                      'Jl. Arumsari Rt. 11 Rw.02 Sambiroto, Semarang',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: wp * 0.03,
                          color: kPrimaryWhite),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.phone),
                      iconSize: hp * 0.025,
                      color: kPrimaryMaroon,
                      onPressed: () {},
                    ),
                    Text(
                      '+6224 7674 6702',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: wp * 0.03,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryWhite),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.mail),
                      iconSize: hp * 0.025,
                      color: kPrimaryMaroon,
                      onPressed: () {},
                    ),
                    Text(
                      'diklat_jateng@pmi.or.id',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: wp * 0.03,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryWhite),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
