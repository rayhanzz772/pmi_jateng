import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class OurServices extends StatefulWidget {
  @override
  _OurServicesState createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
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
        {'icon': 'assets/images/delicious_food.svg', 'label': 'Makanan lezat'},
        {'icon': 'assets/images/restaurant.svg', 'label': 'Restaurant'},
        {'icon': 'assets/images/fitness.svg', 'label': 'Fitness'},
        {'icon': 'assets/images/spa.svg', 'label': 'Spa indah'},
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
                color: _selectedIndex == i ? kPrimaryMaroon : kPrimaryGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    services[i]['icon']!,
                    color: _selectedIndex == i ? kPrimaryGrey : kPrimaryMaroon,
                    height: hp * 0.04,
                    width: wp * 0.04,
                  ),
                  SizedBox(height: 8),
                  Text(
                    services[i]['label']!,
                    style: TextStyle(
                      color:
                          _selectedIndex == i ? kPrimaryGrey : kPrimaryMaroon,
                      fontFamily: 'Judson',
                      fontSize: wp * 0.025,
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
      padding: EdgeInsets.only(top: hp * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 2,
                    width: wp * 0.15,
                    decoration: BoxDecoration(color: kPrimaryMaroon),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Our Services',
                      style: TextStyle(
                        fontFamily: 'Judson',
                        fontSize: wp * 0.06,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 2,
                width: wp * 0.44,
                decoration: BoxDecoration(color: kPrimaryMaroon),
              ),
            ],
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
