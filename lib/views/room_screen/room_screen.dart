import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/component/home_screen/top_bar.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/model/room_type.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/booking/booking.dart';
import 'package:pmi_jateng/views/room_screen/bottombar.dart';

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

  String _formatPrice(String price) {
    try {
      double parsedPrice = double.parse(price);
      return parsedPrice.toStringAsFixed(0); // Format without decimal part
    } catch (e) {
      print('Error parsing price: $e');
      return price; // Return the original string if there's an error
    }
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
          'Rooms',
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
            final List<String> roomImages = roomType.roomImages;

            return Stack(
              children: [
                Column(
                  children: [
                    roomImages.isNotEmpty
                        ? ImageSlideshow(
                            width: double.infinity,
                            height: 250,
                            initialPage: 0,
                            indicatorColor: kPrimaryWhite,
                            indicatorBackgroundColor: Colors.grey,
                            children: roomImages.map<Widget>((imageUrl) {
                              print('Loading image: $imageUrl');

                              Uri uri = Uri.parse(imageUrl);
                              if (uri.isAbsolute) {
                                return Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                throw Exception('Invalid URL: $imageUrl');
                              }
                            }).toList(),
                            onPageChanged: (value) {
                              print('Page changed: $value');
                            },
                            autoPlayInterval: 3000,
                            isLoop: true,
                          )
                        : Container(),
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
                                  roomType.roomType.length > 20
                                      ? roomType.roomType.substring(0, 20) +
                                          '...'
                                      : roomType.roomType,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: wp * 0.04,
                                  ),
                                ),
                                Text(
                                  "Per Malam mulai dari",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: wp * 0.03),
                                ),
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
                                    Text(
                                      'Rp ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                          fontSize: wp * 0.045,
                                          color: kPrimaryMaroon),
                                    ),
                                    Text(
                                      _formatPrice(roomType.price.toString()),
                                      style: TextStyle(
                                          color: kPrimaryMaroon,
                                          fontSize: wp * 0.045,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                roomType.description,
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
                                                        size: wp * 0.035,
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
                                                        size: wp * 0.035,
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
                                                        size: wp * 0.035,
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
                                                        size: wp * 0.035,
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
                                                        size: wp * 0.035,
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
                                                        size: wp * 0.035,
                                                        color:
                                                            kPrimaryFontColor),
                                                    SizedBox(width: 8),
                                                    Text("Kamar Mandi",
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryFontColor)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
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
                    // onCheckout: () => _handleCheckout(
                    //     context, roomType.roomType, roomType.price.toString()),
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
