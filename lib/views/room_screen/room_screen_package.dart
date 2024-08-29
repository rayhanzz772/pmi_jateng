import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/component/home_screen/top_bar.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/model/package_type.dart';
import 'package:pmi_jateng/service/model/room_type.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/booking/booking_package.dart';
import 'package:pmi_jateng/views/booking/booking_regular.dart';
import 'package:pmi_jateng/views/room_screen/bottombar.dart';

class RoomScreenPackage extends StatelessWidget {
  final int id;

  const RoomScreenPackage({Key? key, required this.id}) : super(key: key);

  void _handleCheckout(
      BuildContext context, String price_per_person, String name, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingFormPackage(
          name: name,
          price_per_person: price_per_person,
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
      body: FutureBuilder<PackageType>(
        future: ApiService.fetchPackageTypeById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: kPrimaryMaroon));
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
                    Container(
                      height: 250,
                      width: wp,
                      child: roomType.images.isNotEmpty
                          ? Image.network(
                              roomType.images,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Center(
                                    child: Text(
                                        'Failed to load image')); // Show error message
                              },
                            )
                          : Center(
                              child: Text(
                                  'No images available')), // Handle empty images list
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
                                  roomType.name.length > 20
                                      ? roomType.name.substring(0, 20) + '...'
                                      : roomType.name,
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
                                      _formatPrice(
                                          roomType.pricePerPerson.toString()),
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
                    onCheckout: () => _handleCheckout(context, roomType.name,
                        roomType.pricePerPerson, roomType.id),
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
