import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: Builder(
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(
                right: 16, left: 16, top: hp * 0.01), // Margin di setiap sudut
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              color: kPrimaryWhite, // Mengganti warna top bar menjadi putih
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Perubahan posisi bayangan
                ),
              ],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: kPrimaryColor),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
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
                                fontSize: wp * 0.03,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Jawa Tengah',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: kPrimaryBlack,
                                fontSize: wp * 0.022,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      SizedBox(width: 4),
                      Container(
                        height: hp * 0.03,
                        width: wp * 0.005,
                        decoration: BoxDecoration(color: kPrimaryBlack),
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
                                  color: kPrimaryBlack,
                                  fontSize: wp * 0.018,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Merah',
                                style: TextStyle(
                                  color: kPrimaryBlack,
                                  fontSize: wp * 0.018,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Indonesia',
                                style: TextStyle(
                                  color: kPrimaryBlack,
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
                IconButton(
                  icon: Icon(Icons.account_circle),
                  iconSize: hp * 0.05,
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
