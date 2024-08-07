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
        Get.snackbar('Success', 'Registration successful',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed('/home');
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token.value = data['access_token']; // Save token
        await _saveToken(token.value); // Save token to SharedPreferences
        Get.offNamed('/home'); // Navigate to home page
      } else {
        errorMessage.value = 'Failed to sign in: ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Save token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
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
