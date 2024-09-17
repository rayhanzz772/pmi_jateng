import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/auth_control.dart'; // Pastikan import ini sesuai dengan lokasi file Anda
import 'package:pmi_jateng/views/forgot_password/forgot_password.dart';
import 'package:pmi_jateng/views/sign_up/sign_up.dart';
import 'package:pmi_jateng/utils/color/constant.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthControl authController = Get.put(AuthControl());
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      body: Obx(() {
        if (authController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (authController.errorMessage.isNotEmpty) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(authController.errorMessage.value),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

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
                      Navigator.pushNamed(context, "/welcome_screen");
                    },
                  ),
                  SizedBox(
                      width:
                          10), // Add some spacing between the icon and the image
                  Image.asset(
                    'assets/images/logoPMI.png',
                    height: 40, // Specify the height of the image
                  ),
                ],
              ),
              Container(
                color: kPrimaryWhite,
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    SizedBox(height: 35),
                    TopText(), // Gunakan widget TopText disini
                    SizedBox(height: 60),
                    BoxForm(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// Definisikan widget TopText dalam file yang sama
class TopText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(right: 100),
        ),
      ],
    );
  }
}

class BoxForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  BoxForm({
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final AuthControl authController = Get.find<AuthControl>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 22),
          Text(
            "SIGN IN",
            style: TextStyle(
              fontSize: 22,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
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
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Lupa Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    try {
                      await authController.signInWithEmail(email, password);
                    } catch (e) {
                      print('Error during sign-in: $e');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: kPrimaryColor,
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/sign_up");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun?",
                        style: TextStyle(fontSize: 13, color: kPrimaryBlack),
                      ),
                      Text(
                        " Sign Up",
                        style: TextStyle(
                            fontSize: 13,
                            color: kPrimaryMaroon,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 34),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
