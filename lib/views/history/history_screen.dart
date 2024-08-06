// Profile_screen.dart
import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/views/history/history_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedItem = 0;
  final List<Map<String, String>> rooms = [
    {
      'title': 'Middle meeting room',
      'date': '07/12/2023',
      'code': 'xxxxxx',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'status': 'Selesai',
      'image': 'assets/images/kamar.jpeg', // Add your image asset here
    },
    {
      'title': 'Middle meeting room',
      'date': '07/12/2023',
      'code': 'xxxxxx',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'status': 'Selesai',
      'image': 'assets/images/kamar.jpeg', // Add your image asset here
    },

    // Add more items as needed
  ];
  final List<String> labels = [
    'Semua',
    'Selesai',
    'Proses',
    'Verifikasi',
    'Pending'
  ];
  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
          onPressed: () {
            Get.toNamed('/profile');
          },
        ),
        title: Text(
          'History',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: kPrimaryWhite),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              height: hp * 0.04,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: labels.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItem = index;
                      });
                    },
                    child: Container(
                      width: wp * 0.26,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: selectedItem == index ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          labels[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: wp * 0.04,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(bottom: 200),
              width: wp,
              child: ListView.builder(
                shrinkWrap:
                    true, // Added to make ListView.builder take only needed space
                physics:
                    NeverScrollableScrollPhysics(), // Disable inner ListView scroll
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            room['image']!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room['title']!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                room['date']!,
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${room['code']} (kode pemesanan)',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(room['description']!),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                iconColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: Text(room['status']!),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
