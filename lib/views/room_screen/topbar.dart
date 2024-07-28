import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class Topbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () {
            Navigator.pop(context); // Go back to previous page
          },
        ),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Jawa Tengah',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: kPrimaryBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
              SizedBox(width: 4),
              Container(
                height: 20,
                width: 5,
                decoration: BoxDecoration(color: kPrimaryBlack),
              ),
              SizedBox(width: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Bersih',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: kPrimaryBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
