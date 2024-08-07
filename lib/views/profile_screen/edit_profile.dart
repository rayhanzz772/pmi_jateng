// Profile_screen.dart
import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/views/history/history_screen.dart';
import 'package:pmi_jateng/service/auth_control.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          print('Image picked: ${_image!.path}');
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

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
          'Edit Profile',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: kPrimaryWhite),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: hp,
          width: wp,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  print(
                      'GestureDetector tapped'); // Log when GestureDetector is tapped
                  _pickImage();
                },
                child: Container(
                  height: hp * 0.3,
                  width: wp * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: kPrimaryMaroon),
                    color: kPrimaryBlack,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _image != null
                          ? FileImage(_image!)
                          : AssetImage('assets/images/profile.jpg')
                              as ImageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    TextField(
                      // controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      // controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      // controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      // controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                        onPressed: () {},
                        child: Container(
                          height: hp * 0.07,
                          width: wp,
                          decoration: BoxDecoration(
                              color: kPrimaryMaroon,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Center(
                              child: Text(
                            'Done',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: wp * 0.05,
                                color: kPrimaryWhite,
                                fontWeight: FontWeight.w600),
                          )),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
