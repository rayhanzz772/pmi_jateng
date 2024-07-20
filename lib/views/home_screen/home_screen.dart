import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kPrimaryWhite,
        body: Stack(
          children: [
            // Konten di bawah top bar
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: hp * 0.75,
                    width: wp,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/landing_page.png'),
                            fit: BoxFit.cover)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: wp * 0.05, top: hp * 0.09),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Find your ',
                                  style: TextStyle(
                                      fontFamily: 'JosefinSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: wp * 0.12,
                                      color: kPrimaryWhite),
                                ),
                                Text('ideal room',
                                    style: TextStyle(
                                        fontFamily: 'josefinsans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: wp * 0.12,
                                        color: kPrimaryWhite)),
                                Container(
                                  height: hp * 0.03,
                                  width: wp * 0.25,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/Vector.png'),
                                          fit: BoxFit.contain)),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: hp * 0.15,
                                width: wp * 0.35,
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.only(
                                    right: wp * 0.05,
                                    top: hp * 0.09,
                                    left: wp * 0.05),
                                decoration: BoxDecoration(
                                    color: kPrimaryMaroon,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: [
                                    Container(
                                      width: wp,
                                      height: hp * 0.09,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(17)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/our_room.jpg'),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(hp * 0.01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Our rooms',
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: wp * 0.037,
                                                fontWeight: FontWeight.w600,
                                                color: kPrimaryWhite),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                            width: wp * 0.07,
                                            height: hp * 0.03,
                                            decoration: BoxDecoration(
                                              color: kPrimaryWhite,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: kPrimaryMaroon,
                                                size: wp * 0.05,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: hp * 0.15,
                                width: wp * 0.35,
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.only(
                                    right: wp * 0.05, top: hp * 0.09),
                                decoration: BoxDecoration(
                                    color: kPrimaryMaroon,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: [
                                    Container(
                                      width: wp,
                                      height: hp * 0.09,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(17)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/our_room.jpg'),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(hp * 0.01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Our rooms',
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: wp * 0.037,
                                                fontWeight: FontWeight.w600,
                                                color: kPrimaryWhite),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                            width: wp * 0.07,
                                            height: hp * 0.03,
                                            decoration: BoxDecoration(
                                              color: kPrimaryWhite,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: kPrimaryMaroon,
                                                size: wp * 0.05,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: hp * 0.2,
                    decoration: BoxDecoration(
                      color: kPrimaryMaroon,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: wp,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Book now your ideal room',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: wp * 0.04,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryWhite),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  color: kPrimaryMaroon,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Arrival date',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: wp * 0.03,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'poppins'),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '18/07/2024',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Container(
                                            width:
                                                100, // Width of the underline
                                            height:
                                                1, // Height of the underline
                                            color: Colors
                                                .white, // Color of the underline
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: kPrimaryMaroon,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: hp * 0.4,
                    child: Row(
                      children: [
                        Container(
                          width: wp * 0.4,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: kPrimaryMaroon, width: 2),
                            bottom: BorderSide(color: kPrimaryMaroon, width: 2),
                          )),
                          child: Column(
                            children: [
                              Container(
                                height: hp * 0.13,
                              ),
                              Container(
                                height: hp * 0.13,
                              ),
                              Container(
                                height: hp * 0.12,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: wp * 0.06,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: kPrimaryMaroon, width: 2),
                                  bottom: BorderSide(
                                      color: kPrimaryMaroon, width: 2))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: hp * 0.01),
                                      width: 2,
                                      height: hp * 0.09,
                                      color:
                                          kPrimaryMaroon, // Color of the top line
                                    ),
                                    RotatedBox(
                                      quarterTurns: 5,
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
                                      height: hp * 0.236,
                                      color:
                                          kPrimaryMaroon, // Color of the bottom line
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
                                  top: BorderSide(
                                      color: kPrimaryMaroon, width: 2),
                                  bottom: BorderSide(
                                      color: kPrimaryMaroon, width: 2))),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Top bar yang tetap di atas
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.only(
                        right: 16,
                        left: 16,
                        top: hp * 0.01), // Margin di setiap sudut
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                      color:
                          kPrimaryWhite, // Mengganti warna top bar menjadi putih
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
                                            image: AssetImage(
                                                'assets/images/logo.png'),
                                            fit: BoxFit.cover),
                                      )),
                                  SizedBox(width: 7),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context); // Menutup drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context); // Menutup drawer
                },
              ),
              // Tambahkan item menu lain sesuai kebutuhan
            ],
          ),
        ),
      ),
    );
  }
}
