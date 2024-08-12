import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:pmi_jateng/service/model/room_type.dart';
import 'package:pmi_jateng/service/model/meeting_room.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'package:pmi_jateng/service/auth_control.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
// Menampilkan jenis ruangan
  static Future<List<MeetRoom>> fetchRoomTypes() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/v1/room_type/getAll"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData.map((json) => MeetRoom.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load room types');
    }
  }

// Mengambil data dari ruangan yang dipilih
  static Future<RoomType> fetchRoomTypeById(int id) async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/v1/room_type/getDetail?id=$id"));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Debugging
      print('JSON Data: $jsonData');

      final roomData = jsonData['room_data'];
      final roomImages = jsonData['room_images'];

      if (roomData == null) {
        throw Exception('room_data is null');
      }

      // Check for missing fields in room_data
      List<String> missingFields = [];
      if (roomData['id'] == null) missingFields.add('id');
      if (roomData['room_type'] == null) missingFields.add('room_type');
      if (roomData['capacity'] == null) missingFields.add('capacity');
      if (roomData['price'] == null) missingFields.add('price');
      if (roomData['description'] == null) missingFields.add('description');

      if (missingFields.isNotEmpty) {
        throw Exception(
            'Missing fields in room_data: ${missingFields.join(', ')}');
      }

      try {
        // Create RoomType from room_data and room_images
        return RoomType(
          id: roomData['id'],
          roomType: roomData['room_type'],
          capacity: roomData['capacity'],
          price: roomData['price'],
          description: roomData['description'],
          roomImages: List<String>.from(
              roomImages ?? []), // Default to empty list if room_images is null
        );
      } catch (e) {
        throw Exception('Error parsing room data: $e');
      }
    } else {
      throw Exception(
          'Failed to load room type. Status code: ${response.statusCode}');
    }
  }

// Mengambil data transaksi per email
  static Future<List<Map<String, dynamic>>> fetchUserTransactions(
      String email, String? token) async {
    final url =
        '$baseUrl/api/v1/user_transaction/getUserTransaction?user_email=$email';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Failed to load transactions: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }

// Untuk menambahkan data pada booking
  Future<String?> insertData(
      {required String email,
      required String id,
      required String start_dt,
      required String end_dt,
      required String amo,
      required String sd}) async {
    final Map<String, dynamic> data = {
      "user_email": email,
      "room_type_id": id,
      "start_date": start_dt,
      "end_date": end_dt,
      "amount": amo,
      "side": "client"
    };

    print('Sending request with parameters:');
    print('user_email: $email (type: ${email.runtimeType})');
    print('room_type_id: $id (type: ${id.runtimeType})');
    print('start_date: $start_dt (type: ${start_dt.runtimeType})');
    print('end_date: $end_dt (type: ${end_dt.runtimeType})');
    print('amount: $amo (type: ${amo.runtimeType})');
    print('side: $sd (type: ${sd.runtimeType})');

    try {
      Dio dio = Dio();
      final response = await dio.post(
        "$baseUrl/api/v1/booking/generateToken",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final responseBody = response.data;
        final snapToken = responseBody['snap_token'];
        return snapToken; // Kembalikan snapToken
      } else {
        print('Failed to insert data');
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.data}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  //
  static Future<bool> updateUserProfile(
      String name, String phone, String? token) async {
    final url = '$baseUrl/api/v1/updateProfile';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        return true;
      } else {
        print('Failed to update profile: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  // Fetch API Test
  Future<Map<String, dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/v1/room_type/getAll"));

    if (response.statusCode == 200) {
      // Parse the JSON response
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> forgotPassword(BuildContext context) async {
    // Tampilkan dialog input email
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Forgot Password'),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: "Enter your email"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Submit'),
            onPressed: () async {
              final email = emailController.text;
              if (email.isNotEmpty) {
                Navigator.of(context).pop(); // Close the dialog
                await sendForgotPasswordRequest(email);
              } else {
                Get.snackbar(
                  'Error',
                  'Please enter your email',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> sendForgotPasswordRequest(String email) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/v1/forgotPassword"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        Get.snackbar('Success', 'Password reset email sent',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        print('Response status: ${response.statusCode}');

        Get.snackbar(
          'Error',
          'Failed to send password reset email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
