import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/views/history/history_screen.dart';
import 'package:pmi_jateng/service/auth_control.dart';
import 'package:pmi_jateng/views/profile_screen/information.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _email;
  String? _token;
  String? _name;
  bool _isLoading = true;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token');
      _name = prefs.getString('auth_name');
      _email = prefs.getString('auth_email');
      _isLoading = false;
    });
    print('Email: $_email');
    print('name: $_name');
    print('Token: $_token');
  }

  Future<void> _signOut(BuildContext context) async {
    final authControl = Get.find<AuthControl>();
    authControl.clearToken();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/sign_in', (Route<dynamic> route) => false);
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _saveLogin();
    _loadProfileImage();
  }

  String capitalize(String? s) {
    if (s == null || s.isEmpty) {
      return 'No Name';
    }
    return s
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  Future<bool> _onWillPop() async {
    // Navigate to HomeScreen when the back button is pressed
    Get.offNamedUntil('/home', (route) => false);
    return false; // Prevent default back navigation
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: kPrimaryWhite,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_token == null || _email == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Get.offNamed('/sign_in');
      });
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kPrimaryWhite),
            onPressed: () {
              Get.toNamed('/home');
            },
          ),
          title: Text(
            'Profile',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: kPrimaryWhite),
          ),
        ),
        body: Container(
          height: hp,
          width: wp,
          decoration: BoxDecoration(color: kPrimaryWhite),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: wp * 0.45,
                height: hp * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryMaroon, width: 3),
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage('assets/images/profile.jpg')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    capitalize(_name) ?? 'No Name',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: wp * 0.06,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(_email ?? 'No Email'),
                  SizedBox(height: 10),
                  TextButton(
                      onPressed: () {
                        Get.toNamed('/edit_profile');
                      },
                      child: Container(
                        height: hp * 0.05,
                        width: wp * 0.4,
                        decoration: BoxDecoration(
                            color: kPrimaryMaroon,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontFamily: 'Poppins', color: kPrimaryWhite),
                        )),
                      ))
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 1,
                width: wp * 0.9,
                color: kPrimaryMaroon,
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen()),
                      );
                    },
                    child: Container(
                      color: kPrimaryWhite,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: wp * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: hp * 0.06,
                                width: wp * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  shape: BoxShape.rectangle,
                                  color: kPrimaryGrey,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.timelapse,
                                    color: kPrimaryMaroon,
                                    size: wp * 0.08,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Transaction History',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: wp * 0.043),
                              )
                            ],
                          ),
                          Container(
                            height: hp * 0.03,
                            width: wp * 0.07,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: kPrimaryMaroon,
                                size: wp * 0.08,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InformationScreen()),
                      );
                    },
                    child: Container(
                      color: kPrimaryWhite,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: wp * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: hp * 0.06,
                                width: wp * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  shape: BoxShape.rectangle,
                                  color: kPrimaryGrey,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.info_outlined,
                                    color: kPrimaryMaroon,
                                    size: wp * 0.08,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Information',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: wp * 0.043),
                              )
                            ],
                          ),
                          Container(
                            height: hp * 0.03,
                            width: wp * 0.07,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: kPrimaryMaroon,
                                size: wp * 0.08,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      await _signOut(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: hp * 0.16),
                      width: wp * 0.9,
                      height: hp * 0.07,
                      decoration: BoxDecoration(
                          color: kPrimaryMaroon,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        'Log Out',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: kPrimaryWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: wp * 0.04),
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
