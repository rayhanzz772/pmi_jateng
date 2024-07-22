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
      height: hp * 0.3,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: wp * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 2, color: Colors.red),
                    ),
                  ),
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      fontFamily: 'Judson',
                      fontSize: wp * 0.06,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: hp * 0.2,
                  width: wp * 0.8,
                  child: Expanded(
                    child: SvgPicture.asset(
                      'assets/images/about_us.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              color: kPrimaryColor,
              padding: EdgeInsets.all(10),
              child: Text(
                'GEDUNG DIKLAT PMI PROVINSI JAWA TENGAH Terletak di kawasan perbukitan di Kota Semarang yang memiliki suasana nyaman dan jauh dari kebisingan kota, sehingga cocok digunakan untuk tempat rapat, pendidikan, pelatihan, seminar, dan lainnya. Lingkungan Gedung Diklat yang Hijau dan rumah belajar memiliki beragam fasilitas yang tersedia serta pilihan menu hidangan yang ditawarkan berinovasi sehat dan lezat.',
                style: TextStyle(
                  fontFamily: 'Judson',
                  fontSize: wp * 0.04,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
