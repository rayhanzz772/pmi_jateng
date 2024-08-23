import 'package:flutter/material.dart';
import 'package:pmi_jateng/service/model/meeting_room_paket.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/room_screen/room_screen_package.dart';
import 'package:pmi_jateng/views/room_screen/room_screen_regular.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/model/meeting_room.dart';

class MeetingRoomCard extends StatelessWidget {
  const MeetingRoomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<MeetRoom>>(
            future: ApiService.fetchRoomTypes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                final rooms = snapshot.data!;

                return Container(
                  height: hp * 0.62,
                  width: wp,
                  padding:
                      EdgeInsets.symmetric(horizontal: 7, vertical: hp * 0.02),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Regular',
                              style: TextStyle(
                                  fontFamily: 'Freehand',
                                  fontSize: wp * 0.08,
                                  color: Colors.red),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Room',
                              style: TextStyle(
                                  fontFamily: 'Judson',
                                  fontSize: wp * 0.08,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: hp * 0.02),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: rooms.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final room = rooms[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RoomScreenRegular(id: room.id),
                                  ),
                                );
                              },
                              child: Container(
                                width: wp * 0.8,
                                margin: EdgeInsets.only(right: wp * 0.02),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: hp * 0.26,
                                        width: wp * 0.8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(room.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          room.roomType,
                                          style: TextStyle(
                                            fontSize: wp * 0.04,
                                            color: kPrimaryBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          room.description,
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: wp * 0.035,
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: List.generate(5, (index) {
                                            return Icon(Icons.star,
                                                color: Colors.red, size: 16);
                                          }),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Add navigation or any other functionality here
                                          },
                                          child: Text(
                                            'View More',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'poppins',
                                              fontSize: wp * 0.035,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          FutureBuilder<List<MeetRoomPaket>>(
            future: ApiService.fetchPackageTypes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData) {
                return Center(child: Text('No package data available'));
              } else {
                final package = snapshot.data!;

                return Container(
                  height: hp * 0.62,
                  width: wp,
                  padding:
                      EdgeInsets.symmetric(horizontal: 7, vertical: hp * 0.02),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Paket',
                              style: TextStyle(
                                  fontFamily: 'Freehand',
                                  fontSize: wp * 0.08,
                                  color: Colors.red),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Room',
                              style: TextStyle(
                                  fontFamily: 'Judson',
                                  fontSize: wp * 0.08,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: hp * 0.02),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: package.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final packages = package[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RoomScreenPackage(id: packages.id),
                                  ),
                                );
                              },
                              child: Container(
                                width: wp * 0.8,
                                margin: EdgeInsets.only(right: wp * 0.02),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: hp * 0.26,
                                        width: wp * 0.8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                packages.thumbnail),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          packages.name,
                                          style: TextStyle(
                                            fontSize: wp * 0.04,
                                            color: kPrimaryBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          packages.description,
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: wp * 0.035,
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: List.generate(5, (index) {
                                            return Icon(Icons.star,
                                                color: Colors.red, size: 16);
                                          }),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Add navigation or any other functionality here
                                          },
                                          child: Text(
                                            'View More',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'poppins',
                                              fontSize: wp * 0.035,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
