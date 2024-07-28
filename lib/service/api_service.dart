import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8001/api/insert';
  static const String apiUrl = 'http://10.0.2.2:8000/api/room_type/getAll';

  Future<String?> insertData({
    required String name,
    required String phone,
    required int guests,
    required String email,
    required int harga,
    required DateTime checkinTime,
    required DateTime checkoutTime,
  }) async {
    final Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'guests': guests,
      'email': email,
      'harga': harga,
      'checkintime': checkinTime.toIso8601String(),
      'checkouttime': checkoutTime.toIso8601String(),
    };

    try {
      Dio dio = Dio();
      final response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: data,
      );

      if (response.statusCode == 201) {
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
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the JSON response
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
