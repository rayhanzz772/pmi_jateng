import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class Sidebar extends StatelessWidget {
  final GetStorage _box = GetStorage();

  Future<void> _signOut(BuildContext context) async {
    await _box.remove('auth_token'); // Remove auth token from storage
    await _box.write('isLoggedIn', false); // Update login status

    // Navigate to sign-in page
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
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
