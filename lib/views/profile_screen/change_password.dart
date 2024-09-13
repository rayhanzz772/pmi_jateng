import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:pmi_jateng/utils/color/constant.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  String? _token; // Untuk menyimpan token yang diambil dari SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadToken(); // Load token ketika widget diinisialisasi
  }

  // Fungsi untuk mengambil token dari SharedPreferences
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs
          .getString('auth_token'); // Mengambil token dari SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
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
            'Change Password',
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
                SizedBox(height: 16.0),
                TextField(
                  controller: currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    labelStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmation Password',
                    labelStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                _isLoading
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: () async {
                          String currentPassword =
                              currentPasswordController.text;
                          String newPassword = newPasswordController.text;
                          String confirmPassword =
                              confirmPasswordController.text;

                          // Validasi input
                          if (newPassword != confirmPassword) {
                            Get.snackbar('Error',
                                'New password and confirmation do not match',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }

                          if (currentPassword.isEmpty ||
                              newPassword.isEmpty ||
                              confirmPassword.isEmpty) {
                            Get.snackbar('Error', 'Please fill in all fields',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }

                          // Pastikan token tidak null sebelum memproses
                          if (_token == null) {
                            Get.snackbar('Error',
                                'Token not found. Please log in again.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                            return;
                          }

                          // Set loading state
                          setState(() {
                            _isLoading = true;
                          });

                          // Panggil ApiService untuk update password
                          bool success = await ApiService().changePassword(
                              currentPassword,
                              newPassword,
                              confirmPassword,
                              _token); // Menggunakan token dari SharedPreferences

                          // Set loading state kembali
                          setState(() {
                            _isLoading = false;
                          });

                          if (success) {
                            // Jika berhasil, navigasi kembali ke profile
                            Get.snackbar(
                                'Success', 'Password updated successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white);
                            Get.toNamed('/profile');
                          } else {
                            Get.snackbar('Error', 'Failed to update password',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
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
      ),
    );
  }
}
