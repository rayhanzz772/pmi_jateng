import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api/insert';

  Future<void> submitBooking({
    required String name,
    required String phone,
    required int guests,
    required DateTime checkInDate,
    required TimeOfDay checkInTime,
    required DateTime checkOutDate,
    required TimeOfDay checkOutTime,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/order'));
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to submit booking bro');
    }
  }

  // Future<void> submitBooking2({
  //   required String name,
  // }) async {
  //   final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/order'));
  //   request.fields['name'] = name;
  //   final response = await request.send();
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to submit booking bro');
  //   }
  // }

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
}
