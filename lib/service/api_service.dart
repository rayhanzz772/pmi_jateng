import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:pmi_jateng/service/model/booking_detail.dart';
import 'package:pmi_jateng/service/model/room_type.dart';
import 'package:pmi_jateng/service/model/package_type.dart';
import 'package:pmi_jateng/service/model/meeting_room.dart';
import 'package:pmi_jateng/service/model/meeting_room_paket.dart';
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
          roomImages: List<String>.from(roomImages ?? []),
        );
      } catch (e) {
        throw Exception('Error parsing room data: $e');
      }
    } else {
      throw Exception(
          'Failed to load room type. Status code: ${response.statusCode}');
    }
  }

  static Future<List<MeetRoomPaket>> fetchPackageTypes() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/v1/packages/getAll"));

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}'); // Tambahkan logging

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print('Parsed data: $jsonData'); // Tambahkan logging untuk parsed data

      return jsonData.map((json) => MeetRoomPaket.fromJson(json)).toList();
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to load room types');
    }
  }

// Mengambil data dari ruangan yang dipilih

  static Future<PackageType> fetchPackageTypeById(int id) async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/v1/packages/getDetail?id=$id"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return PackageType.fromJson(data[0]);
      } else {
        throw Exception('No data found');
      }
    } else {
      throw Exception('Failed to load package details');
    }
  }

// Mengambil data transaksi per email
  static Future<List<Map<String, dynamic>>> fetchUserTransactions(
      String email, String? token) async {
    final url =
        '$baseUrl/api/v2/user_transaction/getUserTransaction?user_email=$email';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Print the entire response body for debugging
        print('Response body: ${response.body}');

        // Parse the response as a Map<String, dynamic>
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Convert the map values to a list of transactions
        final List<Map<String, dynamic>> transactions =
            data.values.map((e) => Map<String, dynamic>.from(e)).toList();

        return transactions;
      } else {
        print('Failed to load transactions: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }

  static Future<BookingDetail?> fetchUserTransactionsById(
      int id, String userEmail, String? token) async {
    // Bangun URL dengan id dan email
    final url =
        '$baseUrl/api/v2/user_transaction/detail?id=$id&user_email=$userEmail';

    try {
      // Mengirim permintaan GET dengan header otorisasi
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      // Cek apakah respon sukses
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        // Memastikan data tidak null atau kosong
        if (data.isNotEmpty) {
          return BookingDetail.fromJson(data);
        } else {
          // Jika data kosong, kembalikan null
          return null;
        }
      } else {
        throw Exception(
            'Failed to load transaction details, status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error
      print('Error fetching transaction details: $e');
      return null;
    }
  }

// Untuk menambahkan data pada booking
  Future<String?> BookingRegular({
    required String email,
    required String id,
    required String start_dt,
    required String end_dt,
    required String amo,
    required String sd,
    required String token,
  }) async {
    // Persiapan data untuk POST request
    final Map<String, dynamic> data = {
      "user_email": email,
      "room_type_id": id,
      "start_date": start_dt,
      "end_date": end_dt,
      "amount": amo,
      "side": "client"
    };

    print('Sending request with parameters:');
    data.forEach((key, value) {
      print('$key: $value (type: ${value.runtimeType})');
    });

    try {
      // Menggunakan http untuk POST request
      final response = await http.post(
        Uri.parse(
            "$baseUrl/api/v2/booking/generateToken"), // Ganti dengan URL yang benar
        headers: {
          'Authorization': 'Bearer $token', // Gunakan token otorisasi
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data), // Konversi body ke JSON
      );

      // Cek status code dari response
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody != null && responseBody['snap_token'] != null) {
          final snapToken = responseBody['snap_token'];
          return snapToken; // Kembalikan snapToken
        } else {
          print('Invalid response data: ${response.body}');
          return null;
        }
      } else {
        print('Failed to insert data');
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Untuk menambahkan data pada booking
  Future<String?> BookingPackage(
      {required String user_email,
      required String package_id,
      required String start_dt,
      required String end_dt,
      required String person_count,
      required String token,
      required String sd}) async {
    final Map<String, dynamic> data = {
      "user_email": user_email,
      "package_id": package_id,
      "start_date": start_dt,
      "end_date": end_dt,
      "person_count": person_count,
      "side": "client"
    };

    print('Sending request with parameters:');
    print('user_email: $user_email (type: ${user_email.runtimeType})');
    print('package_id: $package_id (type: ${package_id.runtimeType})');
    print('start_date: $start_dt (type: ${start_dt.runtimeType})');
    print('end_date: $end_dt (type: ${end_dt.runtimeType})');
    print('person_count: $person_count (type: ${person_count.runtimeType})');
    print('side: $sd (type: ${sd.runtimeType})');

    try {
      final response =
          await http.post(Uri.parse("$baseUrl/api/v2/booking/packageToken"),
              headers: {
                'Authorization': 'Bearer $token', // Gunakan token otorisasi
                'Content-Type': 'application/json',
              },
              body: jsonEncode(data));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody != null && responseBody['snap_token'] != null) {
          final snapToken = responseBody['snap_token'];
          return snapToken; // Kembalikan snapToken
        } else {
          print('Invalid response data: ${response.body}');
          return null;
        }
      } else {
        print('Failed to insert data');
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
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
          'Failed to send password reset email, please re-type your email',
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

  Future<bool> changePassword(String currentPassword, String newPassword,
      String confirmPassword, String? token) async {
    try {
      // Kirim POST request ke endpoint untuk update password
      final response = await http.put(
        Uri.parse("$baseUrl/api/v1/updatePassword"),
        headers: {
          'Authorization': 'Bearer $token', // Token JWT perlu dikirim di header
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'current_password': currentPassword, // Password lama
          'password': newPassword, // Password baru
          'password_confirmation': confirmPassword,
        }),
      );

      // Log untuk debugging
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      // Cek status kode dari response
      if (response.statusCode == 200) {
        // Coba parsing responsenya hanya jika JSON
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          final responseData = jsonDecode(response.body);

          // Lakukan apa yang diperlukan, misalnya simpan token baru
          final newToken = responseData['access_token'];
          print("Password updated successfully. New token: $newToken");

          // Simpan token baru jika diperlukan
          // await saveNewToken(newToken);

          return true; // Indicate success
        } else {
          print("Unexpected content type: ${response.headers['content-type']}");
          return false; // Indicate failure
        }
      } else {
        // Jika gagal, tampilkan pesan kesalahan
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          final errorData = jsonDecode(response.body);
          print("Failed to update password: ${errorData['error']}");
        } else {
          print(
              "Failed to update password. Response body: ${response.statusCode}");
        }
        return false; // Indicate failure
      }
    } catch (error) {
      // Tangani error saat melakukan request
      print("An error occurred: $error");
      return false; // Indicate failure in case of an error
    }
  }
}
