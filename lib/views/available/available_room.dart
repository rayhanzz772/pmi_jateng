import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/room_screen/room_screen_regular.dart';

class AvailableScreen extends StatefulWidget {
  final List<dynamic> data;

  AvailableScreen({Key? key, required this.data}) : super(key: key);

  @override
  _AvailableScreenState createState() => _AvailableScreenState();
}

class _AvailableScreenState extends State<AvailableScreen> {
  late List<dynamic> filteredData; // List to hold filtered data
  late TextEditingController
      searchController; // TextEditingController for search input

  @override
  void initState() {
    super.initState();
    filteredData = widget.data; // Initialize with all data
    searchController = TextEditingController(); // Initialize search controller

    // Add listener to update filtered data when search input changes
    searchController.addListener(() {
      filterRooms();
    });
  }

  void filterRooms() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredData = widget.data
          .where((room) => room['room_type'].toLowerCase().contains(query))
          .toList(); // Filter based on search input
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose controller when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryMaroon,
        leading: IconButton(
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryWhite,
          ),
        ),
        title: Text(
          'Available Room',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: wp * 0.05,
            color: kPrimaryWhite,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                controller: searchController, // Set the controller here
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search room type',
                ),
              ),
            ),
            SizedBox(
              height: hp * 0.02,
            ),
            Column(
              children: filteredData.map<Widget>((room) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to RoomScreenRegular with the selected room ID
                    Get.to(RoomScreenRegular(
                        id: room[
                            'id'])); // Assuming 'id' is the key for room ID
                  },
                  child: Container(
                    height: hp * 0.16,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    decoration: BoxDecoration(
                      color: kPrimaryWhite,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: wp * 0.3,
                          height: hp * 0.17,
                          decoration: BoxDecoration(
                            color: kPrimaryBlack,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                              image: NetworkImage(room['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wp * 0.03,
                        ),
                        Container(
                          width: wp * 0.52,
                          height: hp * 0.13,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Builder(
                                builder: (context) {
                                  final textSpan = TextSpan(
                                    text: room['room_type'],
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: wp * 0.04,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );

                                  // Measure the text height
                                  final textPainter = TextPainter(
                                    text: textSpan,
                                    maxLines: 1,
                                    textDirection: TextDirection.ltr,
                                  )..layout(maxWidth: wp * 0.52);

                                  // Check if it exceeds the height for one line
                                  if (room['room_type'].length > 20) {
                                    return Text(
                                      room['room_type'],
                                      maxLines: 2, // Allow 2 lines if necessary
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize:
                                            wp * 0.035, // Smaller font size
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      room['room_type'],
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: wp * 0.04,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  }
                                },
                              ),
                              Text(
                                room['description'],
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: wp * 0.03,
                                ),
                              ),
                              SizedBox(
                                height: hp * 0.01,
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: kPrimaryBlack,
                                    size: wp * 0.04,
                                  );
                                }),
                              ),
                              SizedBox(
                                height: hp * 0.01,
                              ),
                              Container(
                                height: hp * 0.028,
                                width: wp * 0.52,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: wp * 0.25,
                                    height: hp * 0.3,
                                    decoration: BoxDecoration(
                                      color: kPrimaryMaroon,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Rp. ${room['price']}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: wp * 0.028,
                                          fontWeight: FontWeight.w500,
                                          color: kPrimaryWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
