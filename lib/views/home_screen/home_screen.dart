import 'package:flutter/material.dart';
import 'package:pmi_jateng/component/home_screen/our_services.dart';
import 'package:pmi_jateng/component/home_screen/superior_room.dart';
import 'package:pmi_jateng/component/home_screen/top_bar.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/component/home_screen/meeting_room.dart';
import 'package:pmi_jateng/component/home_screen/sidebar.dart';
import 'package:pmi_jateng/component/home_screen/book_now.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Scaffold(
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
                          margin: EdgeInsets.only(top: hp * 0.09),
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
                              width: wp * 0.4,
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
                              width: wp * 0.4,
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
                                                'assets/images/room_2.jpg'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(hp * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Meets rooms',
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
                BookNow(),
                SuperiorRoom(),
                Container(
                  height: hp * 0.6,
                  width: wp,
                  padding: EdgeInsets.only(top: hp * 0.02, right: 7, left: 7),
                  decoration: BoxDecoration(color: kPrimaryWhite),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Meeting',
                              style: TextStyle(
                                  fontFamily: 'Freehand',
                                  fontSize: wp * 0.08,
                                  color: kPrimaryMaroon),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Room',
                              style: TextStyle(
                                  fontFamily: 'Judson',
                                  fontSize: wp * 0.08,
                                  color: kPrimaryBlack),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: rooms.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 300, // Set a fixed width for each item
                              child: MeetingRoomCard(
                                title: rooms[index]['title']!,
                                description: rooms[index]['description']!,
                                image: rooms[index]['image']!,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                OurServices()
              ],
            ),
          ),
          // Top bar
          TopBar()
        ],
      ),
      drawer: Sidebar(),
    );
  }
}
