import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pmi_jateng/service/model/room_type.dart';
import 'config.dart';

class ApiService {
// Menampilkan jenis ruangan
  static Future<List<RoomType>> fetchRoomTypes() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/v1/room_type/getAll"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData.map((json) => RoomType.fromJson(json)).toList();
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

      if (jsonData['room_data'] == null) {
        throw Exception('room_data is null');
      }

      dynamic roomData = jsonData['room_data'];

      // If room_data is a string, try to decode it
      if (roomData is String) {
        try {
          roomData = json.decode(roomData);
        } catch (e) {
          throw Exception('Error decoding room_data string: $e');
        }
      }

      if (roomData is Map<String, dynamic>) {
        return RoomType.fromJson(roomData);
      } else {
        throw Exception(
            'Unexpected type for room_data: ${roomData.runtimeType}');
      }
    } else {
      throw Exception('Failed to load room type');
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
      "start_date": "2024-08-06",
      "end_date": "2024-08-06",
      "amount": amo,
      "side": "client"
    };

    print('Sending request with parameters:');
    // print('user_email: $user_email (type: ${user_email.runtimeType})');
    // print('room_type_id: $id (type: ${id.runtimeType})');
    // print('start_date: $start_date (type: ${start_date.runtimeType})');
    // print('end_date: $end_date (type: ${end_date.runtimeType})');
    // print('amount: $amount (type: ${amount.runtimeType})');
    // print('side: $side (type: ${side.runtimeType})');

    try {
      Dio dio = Dio();
      final response = await dio.post(
        "https://724b-103-148-235-253.ngrok-free.app/booking/generateToken",
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
}
