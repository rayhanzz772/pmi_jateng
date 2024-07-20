import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class LaporScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Lapor'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: kPrimaryFontColor, // Warna putih untuk area kosong
                height: 50, // Atur tinggi area kosong sesuai kebutuhan
              ),
              ImageSlideshow(
                width: double.infinity,
                height: 230,
                initialPage: 0,
                indicatorColor: kPrimaryWhite,
                indicatorBackgroundColor: Colors.grey,
                children: [
                  Image.asset(
                    'assets/images/our_room.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/our_room.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/our_room.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
                onPageChanged: (value) {
                  print('Page changed: $value');
                },
                autoPlayInterval: 3000,
                isLoop: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "JENIS KAMAR",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          Text("Per Malam mulai dari")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 19.0,
                              );
                            }),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: kPrimaryFontColor,
                                size: 24.0,
                              ),
                              Text(
                                "Rp. 200.000",
                                style: TextStyle(
                                  color: kPrimaryFontColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        decoration: BoxDecoration(
                          color: kPrimaryGrey,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 15, top: 10, right: 15, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Fasilitas",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.wifi,
                                                  size: 18,
                                                  color: kPrimaryFontColor),
                                              SizedBox(width: 8),
                                              Text(
                                                "Wifi",
                                                style: TextStyle(
                                                    color: kPrimaryFontColor),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 11),
                                          Row(
                                            children: [
                                              Icon(Icons.local_fire_department,
                                                  size: 18,
                                                  color: kPrimaryFontColor),
                                              SizedBox(width: 8),
                                              Text("Air Hangat",
                                                  style: TextStyle(
                                                      color:
                                                          kPrimaryFontColor)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.ac_unit,
                                                  size: 18,
                                                  color: kPrimaryFontColor),
                                              SizedBox(width: 8),
                                              Text("AC",
                                                  style: TextStyle(
                                                      color:
                                                          kPrimaryFontColor)),
                                            ],
                                          ),
                                          SizedBox(height: 11),
                                          Row(
                                            children: [
                                              Icon(Icons.local_laundry_service,
                                                  size: 18,
                                                  color: kPrimaryFontColor),
                                              SizedBox(width: 8),
                                              Text("Laundry",
                                                  style: TextStyle(
                                                      color:
                                                          kPrimaryFontColor)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.tv,
                                                  size: 18,
                                                  color: kPrimaryFontColor),
                                              SizedBox(width: 8),
                                              Text("TV",
                                                  style: TextStyle(
                                                      color:
                                                          kPrimaryFontColor)),
                                            ],
                                          ),
                                          SizedBox(height: 11),
                                          Row(
                                            children: [
                                              Icon(Icons.bed,
                                                  size: 18,
                                                  color: kPrimaryFontColor),
                                              SizedBox(width: 8),
                                              Text("2 Single Bed",
                                                  style: TextStyle(
                                                      color:
                                                          kPrimaryFontColor)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 35, // Padding fdari atas
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                color: kPrimaryWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
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
                            SizedBox(width: 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Palang',
                                  style: TextStyle(
                                    color: kPrimaryBlack,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Merah',
                                  style: TextStyle(
                                    color: kPrimaryBlack,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Indonesia',
                                  style: TextStyle(
                                    color: kPrimaryBlack,
                                    fontSize: 12,
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
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: BottomAppBar(
          color: kPrimaryWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Pesan Kamar'),
                        content: Text('Apakah Anda ingin memesan kamar ini?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Batal'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Pesan'),
                            onPressed: () {
                              // Proses pemesanan kamar
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Pesan Kamar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: kPrimaryFontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
