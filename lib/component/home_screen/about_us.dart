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
      child: Row(
        children: [
          Container(
            width: wp * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 5, left: 5),
                  decoration: BoxDecoration(),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2, color: kPrimaryMaroon),
                      bottom: BorderSide(width: 2, color: kPrimaryMaroon),
                    ),
                  ),
                  child: Container(
                    height: hp * 0.13,
                    width: wp * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/about_us.png'),
                            fit: BoxFit.contain)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: wp * 0.6,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                      color: kPrimaryMaroon,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: kPrimaryMaroon,
                      width: 2,
                    ),
                    bottom: BorderSide(
                      color: kPrimaryMaroon,
                      width: 2,
                    ))),
            child: Container(
              padding: EdgeInsets.all(10),
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
