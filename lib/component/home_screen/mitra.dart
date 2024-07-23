import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class Mitra extends StatefulWidget {
  @override
  _MitraState createState() => _MitraState();
}

class _MitraState extends State<Mitra> {
  int _selectedIndex = -1;

  void _toggleSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    List<Widget> _buildServiceItems() {
      List<Map<String, String>> services = [
        {
          'icon': 'assets/images/save_children.png',
          'label': 'Save The Children'
        },
        {'icon': 'assets/images/pln.png', 'label': 'PLN'},
        {'icon': 'assets/images/aha.png', 'label': 'AHA Center'},
        {'icon': 'assets/images/others.png', 'label': 'Others'},
      ];

      List<Widget> items = [];
      for (int i = 0; i < services.length; i++) {
        items.add(
          GestureDetector(
            onTap: () => _toggleSelection(i),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: hp * 0.1,
              width: wp * 0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: hp * 0.05,
                    width: wp * 0.12,
                    child: Image.asset(
                      services[i]['icon']!,
                      fit: BoxFit.cover, // Adjust as needed
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    services[i]['label']!,
                    style: TextStyle(
                      color: kPrimaryMaroon,
                      fontFamily: 'Judson',
                      fontSize: wp * 0.026,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return items;
    }

    return Container(
      height: hp * 0.19,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(),
            child: Text(
              'Mitra Kami',
              style: TextStyle(
                  fontFamily: 'Judson',
                  fontSize: wp * 0.06,
                  color: kPrimaryMaroon),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: hp * 0.02, right: 7, left: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildServiceItems(),
            ),
          ),
        ],
      ),
    );
  }
}
