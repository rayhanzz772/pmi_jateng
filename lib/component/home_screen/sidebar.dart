import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/service/auth_control.dart';

class Sidebar extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final authControl = Get.find<AuthControl>();

    // Call the clearToken method
    authControl.clearToken();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/sign_in', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryFontColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/profile'); // Navigate to home
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/home'); // Navigate to home
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/history'); // Navigate to home
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Keluar'),
            onTap: () async {
              Navigator.pop(context); // Close the drawer
              await _signOut(context); // Sign out and navigate to login screen
            },
          ),
          // Add other menu items as needed
        ],
      ),
    );
  }
}
