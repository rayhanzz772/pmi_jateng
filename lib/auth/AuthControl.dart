import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
    _loadToken(); // Load token on initialization
  }

  // Method to register
  Future<bool> register(String name, String email, String password,
      String password_confirmation) async {
    isLoading2.value = true;
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.5:8000/api/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password_confirmation,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        errorMessage2.value = 'Failed to register: ${response.body}';
        return false;
      }
    } catch (e) {
      errorMessage2.value = 'An error occurred: $e';
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
        Uri.parse('http://192.168.1.5:8000/api/login'),
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
