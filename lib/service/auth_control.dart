import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_control.dart';
import 'config.dart';

class AuthControl extends GetxController {
  // Reactive variables
  var isLoading2 = false.obs;
  var errorMessage2 = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var token = ''.obs;
  var tokenRegister = ''.obs;

  var userData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }

  // Method to register
  Future<bool> register(String name, String email, String phone,
      String password, String password_confirmation) async {
    isLoading2.value = true;
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/v1/register"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': password_confirmation,
        }),
      );

      // Print the response status code
      print("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('$data');
        Get.snackbar('Success', 'Registration successful',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);

        return true;
      } else {
        Get.snackbar(
          'Error',
          'Registration failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      errorMessage2.value = 'An error occurred: $e';
      Get.snackbar('Error', 'An error occurred: $e',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading2.value = false;
    }
  }

  // Method to sign in
  Future<void> signInWithEmail(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      final data = jsonDecode(response.body);

      if (data['data'] == null) {
        errorMessage.value = 'Check your email or password';
      } else {
        final extractedEmailVerif = data['data']['email_verified_at'];

        if (extractedEmailVerif == null) {
          final extractedEmail = data['data']['email'];
          final extractedName = data['data']['name'];
          final extractedPhone = data['data']['phone'];
          final extractedToken = data['access_token'];

          // Debug prints to verify extracted values
          print('Extracted Email: $extractedEmail');
          print('Extracted Name: $extractedName');
          print('Extracted Phone: $extractedPhone');
          print('Extracted Email Verification: $extractedEmailVerif');
          print('Extracted Token: $extractedToken');
          errorMessage.value = 'Verify your email first';
        } else if (response.statusCode == 200) {
          // Extract email and token from response
          final extractedEmail = data['data']['email'];
          final extractedName = data['data']['name'];
          final extractedPhone = data['data']['phone'];
          final extractedToken = data['access_token'];

          // Debug prints to verify extracted values
          print('Extracted Email: $extractedEmail');
          print('Extracted Name: $extractedName');
          print('Extracted Phone: $extractedPhone');
          print('Extracted Email Verification: $extractedEmailVerif');
          print('Extracted Token: $extractedToken');

          // Save email and token
          await _saveLogin(extractedEmail, extractedToken, extractedName,
              extractedPhone, extractedEmailVerif);

          Get.offNamed('/home');
        } else {
          errorMessage.value = 'Failed to sign in: ${response.body}';
        }
      }
    } catch (e) {
      print('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveLogin(String email, String token, String name, String phone,
      String email_verified_at) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_email', email);
    await prefs.setString('auth_name', name);
    await prefs.setString('auth_phone', phone);
    await prefs.setString('auth_email_verif', email_verified_at);
    await prefs.setString('auth_token', token);
  }

  // Load token from SharedPreferences
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('auth_token');
    if (savedToken != null) {
      token.value = savedToken;
    } else {
      token.value = '';
    }
  }

  // Clear token
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    token.value = '';
  }
}
