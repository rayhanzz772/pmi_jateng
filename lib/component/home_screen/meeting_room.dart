import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class MeetingRoomCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  MeetingRoomCard({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/splash');
        },
        child: Card(
          color: kPrimaryWhite,
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: hp * 0.25,
                width: wp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: wp * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.red, size: 16),
                    Icon(Icons.star, color: Colors.red, size: 16),
                    Icon(Icons.star, color: Colors.red, size: 16),
                    Icon(Icons.star, color: Colors.red, size: 16),
                    Icon(Icons.star, color: Colors.red, size: 16),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Add navigation or any other functionality here
                  },
                  child: Text(
                    'View More',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> rooms = [
  {
    'title': 'Middle meeting room',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'image': 'assets/images/room_1.jpg',
  },
  {
    'title': 'Small meeting room',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'image': 'assets/images/kamar.jpeg',
  },
  {
    'title': 'Big meeting room',
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'image': 'assets/images/meeting room.jpeg',
  },
];
