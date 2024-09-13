import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmi_jateng/service/api_service.dart';
import 'package:pmi_jateng/service/auth_control.dart'; // Pastikan import ini sesuai dengan lokasi file Anda
import 'package:pmi_jateng/utils/color/constant.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

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
                  children: [
                    SizedBox(height: 35),
                    TopText(),
                    SizedBox(height: 60),
                    EmailForm(emailController: emailController),
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

// Widget untuk teks di bagian atas layar
class TopText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          "Reset Your Password",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kPrimaryBlack,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Enter your email address and we'll send you a link to reset your password.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

// Widget untuk form input email
class EmailForm extends StatelessWidget {
  final TextEditingController emailController;

  EmailForm({required this.emailController});

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
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
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
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text;
                    if (email.isNotEmpty) {
                      try {
                        await ApiService().sendForgotPasswordRequest(email);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to send reset link'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a valid email address'),
                          backgroundColor: Colors.red,
                        ),
                      );
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
                    'Send Reset Link',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
