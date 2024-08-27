import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Container(
      height: hp * 0.35,
      margin: EdgeInsets.only(top: hp * 0.01),
      child: Row(
        children: [
          Container(
            width: wp * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      fontFamily: 'Judson',
                      fontSize: wp * 0.06,
                      color: kPrimaryMaroon,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    height: hp * 0.13,
                    width: wp * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/about_us.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: wp * 0.6,
            height: hp * 0.25,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 10),
                'GEDUNG DIKLAT PMI PROVINSI JAWA TENGAH Terletak di kawasan perbukitan di Kota Semarang yang memiliki suasana nyaman dan jauh dari kebisingan kota, sehingga cocok digunakan untuk tempat rapat, pendidikan, pelatihan, seminar, dan lainnya. lingkungan Gedung Diklat yang Hijau dan rumah belajar memiliki beragam fasilitas yang tersedia serta pilihan menu hidangan yang ditawarkan berinovasi sehat dan lezat',
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}
