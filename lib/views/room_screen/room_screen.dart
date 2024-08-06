import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:pmi_jateng/component/home_screen/top_bar.dart';
import 'package:pmi_jateng/service/config.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/model/room_type.dart';
import 'package:pmi_jateng/views/booking/booking.dart';
import 'package:pmi_jateng/views/room_screen/bottombar.dart';
import 'package:get/get.dart';

class RoomScreen extends StatelessWidget {
  final int id;

  const RoomScreen({Key? key, required this.id}) : super(key: key);

  void _handleCheckout(
      BuildContext context, String roomType, String price, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingForm(
          roomType: roomType,
          price: price,
          id: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryMaroon,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () {
            Get.toNamed('/home');
          },
        ),
        title: Text(
          'Home',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: kPrimaryWhite),
        ),
      ),
      backgroundColor: kPrimaryWhite,
      body: FutureBuilder<RoomType>(
        future: ApiService.fetchRoomTypeById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final roomType = snapshot.data!;
            return Stack(
              children: [
                Column(
                  children: [
                    ImageSlideshow(
                      width: double.infinity,
                      height: 250,
                      initialPage: 0,
                      indicatorColor: kPrimaryWhite,
                      indicatorBackgroundColor: Colors.grey,
                      children: [
                        // Image.network("$baseUrl/storage/default_image.jpg",
                        //     fit: BoxFit.cover),
                        Image.asset(
                          'assets/images/kamar.jpeg',
                          fit: BoxFit.cover,
                        )
                      ],
                      onPageChanged: (value) {
                        print('Page changed: $value');
                      },
                      autoPlayInterval: 3000,
                      isLoop: true,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          top: 10,
                          right: 10,
                          left: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  roomType.roomType, // Display room type
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Per Malam mulai dari",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: wp * 0.03),
                                )
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
                                      roomType.price, // Display room price
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
                                roomType
                                    .description, // Display room description
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
                                        left: 15,
                                        top: 10,
                                        right: 15,
                                        bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                        color:
                                                            kPrimaryFontColor),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      "Wifi",
                                                      style: TextStyle(
                                                          color:
                                                              kPrimaryFontColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 11),
                                                Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .local_fire_department,
                                                        size: 18,
                                                        color:
                                                            kPrimaryFontColor),
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
                                                        color:
                                                            kPrimaryFontColor),
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
                                                    Icon(
                                                        Icons
                                                            .local_laundry_service,
                                                        size: 18,
                                                        color:
                                                            kPrimaryFontColor),
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
                                                        color:
                                                            kPrimaryFontColor),
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
                                                        color:
                                                            kPrimaryFontColor),
                                                    SizedBox(width: 8),
                                                    Text("2 bed",
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
                            ),
                            Container(
                              child: Row(
                                children: [Text("TEST")],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomBar(
                    onCheckout: () => _handleCheckout(context,
                        roomType.roomType, roomType.price, roomType.id),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
