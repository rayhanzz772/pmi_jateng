import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(20),
      height: hp * 0.3,
      width: wp,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/contact_us.png'), // Replace with your image asset path
          fit: BoxFit.fitHeight, // Adjust as needed
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: hp * 0.1,
            width: wp * 0.3,
            decoration: BoxDecoration(
                border: Border.all(color: kPrimaryWhite, width: 2),
                shape: BoxShape.circle,
                color: kPrimaryBlack,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile.jpg'),
                  fit: BoxFit.fitHeight,
                )),
          ),
          SizedBox(
            height: hp * 0.01,
          ),
          Text(
            'Rachmatdandy',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: kPrimaryMaroon),
          ),
          SizedBox(
            height: hp * 0.01,
          ),
          Text(
            'Menginap di Pusdiklat sangatlah nyaman, tenang, dan banyak tukang cimol',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: kPrimaryWhite,
                fontSize: wp * 0.03),
          ),
          SizedBox(
            height: hp * 0.01,
          ),
          Text(
            'PT. Menyala Polines',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: kPrimaryWhite,
                fontSize: wp * 0.035),
          )
        ],
      ),
    );
  }
}
