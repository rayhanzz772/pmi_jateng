import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/service/auth_control.dart';
import 'package:pmi_jateng/utils/color/constant.dart';
import 'package:pmi_jateng/views/sign_in/sign_in.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthControl authController = Get.put(AuthControl());
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      body: Obx(() {
        if (authController.isLoading2.value) {
          return Center(child: CircularProgressIndicator());
        } else if (authController.errorMessage2.value.isNotEmpty) {
          print('Error: ${authController.errorMessage2.value}');
          return Center(child: Text(authController.errorMessage2.value));
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: hp * 0.06),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(left: 20),
                      icon: Icon(
                        Icons.arrow_back,
                        color: kPrimaryColor,
                        size: 24,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      'assets/images/logoPMI.png',
                      height: 40,
                    ),
                  ],
                ),
                Container(
                  color: kPrimaryWhite,
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 22),
                            Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: usernameController,
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
                                    controller: emailController,
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
                                    keyboardType: TextInputType.number,
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      labelText: 'phone',
                                      labelStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  TextField(
                                    controller: confirmpasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      labelStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      String username = usernameController.text;
                                      String email = emailController.text;
                                      String phone = phoneController.text;
                                      String password = passwordController.text;
                                      String confirmPassword =
                                          confirmpasswordController.text;
                                      if (password != confirmPassword) {
                                        Get.snackbar(
                                          'Error',
                                          'Passwords do not match',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                        return;
                                      }
                                      authController
                                          .register(username, email, phone,
                                              password, confirmPassword)
                                          .then((success) {
                                        if (success) {
                                          Get.offNamed('/sign_in');
                                        } else {
                                          print('Registration failed');
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      minimumSize: Size(double.infinity, 48),
                                      backgroundColor: kPrimaryColor,
                                    ),
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  GestureDetector(
                                    onTap: () {
                                      Get.offAllNamed("/sign_in");
                                    },
                                    child: Text(
                                      "Don't have an account? Sign In!",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.blue),
                                    ),
                                  ),
                                  SizedBox(height: 34),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
