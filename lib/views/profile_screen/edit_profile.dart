import 'package:flutter/material.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/service/auth_control.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart'; // Import quickalert

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _email;
  String? _token;
  String? _name;
  String? _phone;
  bool _isLoading = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _saveLogin();
    _loadProfileImage();
  }

  Future<void> _saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token');
      _name = prefs.getString('auth_name');
      _email = prefs.getString('auth_email');
      _phone = prefs.getString('auth_phone');
      _nameController.text = _name ?? '';
      _phoneController.text = _phone ?? '';
      _isLoading = false;
    });
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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      // Save the file path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', pickedFile.path);

      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile image updated successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context); // Close the bottom sheet after image is selected
    }
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Profile Image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateUserProfile() async {
    final name = _nameController.text;
    final phone = _phoneController.text;

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Name and Phone fields cannot be empty'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      final success = await ApiService.updateUserProfile(name, phone, _token);

      if (success) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Profile updated successfully. Please relog.',
          confirmBtnText: 'Relog',
          onConfirmBtnTap: () async {
            // Optionally perform relog action here
            final authControl = Get.find<AuthControl>();
            authControl.clearToken();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/sign_in', (Route<dynamic> route) => false);
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update profile'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
        backgroundColor: Colors.red,
      ));
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
            color: kPrimaryWhite,
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                height: hp,
                width: wp,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _showImagePickerSheet,
                      child: Container(
                        height: hp * 0.3,
                        width: wp * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: kPrimaryMaroon),
                          color: kPrimaryBlack,
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
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _nameController,
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
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                      onPressed: _updateUserProfile,
                      child: Container(
                        height: hp * 0.07,
                        width: wp,
                        decoration: BoxDecoration(
                          color: kPrimaryMaroon,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Center(
                          child: Text(
                            'Done',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: wp * 0.05,
                              color: kPrimaryWhite,
                              fontWeight: FontWeight.w600,
                            ),
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
