import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _isLoggedIn = false.obs;

  final Dio _dio = Dio();

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isLoggedIn => _isLoggedIn.value;

  var isLoading2 = false.obs;
  var errorMessage2 = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = GetStorage().read('auth_token');
    _isLoggedIn.value = token != null;
  }

  Future<void> signInWithEmail(String email, String password) async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['data']['token'];
        await GetStorage().write('auth_token', token);
        // Print token to terminal
        print('Auth Token: $token');
        _isLoggedIn.value = true;
        Get.offNamed('/home');
      } else {
        final data = jsonDecode(response.body);
        _errorMessage.value = data['message'];
      }
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  // Future<void> register(String name, String email, String password,
  //     String confirmPassword) async {
  //   isLoading2.value = true;
  //   try {
  //     final response = await _dio.post(
  //       'http://localhost:8000/api/register',
  //       data: {
  //         'name': name,
  //         'email': email,
  //         'password': password,
  //         'c_password': confirmPassword,
  //       },
  //     );

  //     final data = response.data;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoggedIn', true);
  //     await prefs.setString('token', data['data']['token']);

  //     Get.offNamed('/home'); // Navigate to home screen
  //   } catch (e) {
  //     errorMessage2.value = 'Registration failed: ${e.toString()}';
  //   } finally {
  //     isLoading2.value = false;
  //   }
  // }

  void signOut() async {
    await GetStorage().remove('auth_token');
    _isLoggedIn.value = false;
  }
}
