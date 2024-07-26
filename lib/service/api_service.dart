import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/insert';

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

  Future<void> insertData({
    required String name,
    required String phone,
    required int guests,
    required String email,
    required int harga,
    required DateTime checkinTime,
    required DateTime checkoutTime,
  }) async {
    // Membuat map untuk body request
    final Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'guests': guests,
      'email': email,
      'harga': harga,
      'checkintime': checkinTime
          .toIso8601String(), // Mengonversi DateTime ke format string
      'checkouttime': checkoutTime
          .toIso8601String(), // Mengonversi DateTime ke format string
    };

    try {
      // Mengirim POST request menggunakan Dio
      Dio dio = Dio();
      final response = await dio.post(
        'http://127.0.0.1:8000/api/insert', // Ganti dengan base URL API Anda
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: data,
      );

      // Mengecek status code dari response
      if (response.statusCode == 201) {
        // Response sukses
        final responseBody = response.data;
        final snapToken =
            responseBody['snap_token']; // Mendapatkan snap token dari response

        print('Data inserted successfully');
        print('Response body: ${response.data}');
        print('Snap token: $snapToken');

        // You can now use the snapToken for further processing
      } else {
        // Response error
        print('Failed to insert data');
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (e) {
      // Menangani exception
      if (e is DioError) {
        // Menangani DioError secara spesifik
        print('DioError: ${e.message}');
        print('Response status: ${e.response?.statusCode}');
        print('Response body: ${e.response?.data}');
      } else {
        // Menangani exception lainnya
        print('Error: $e');
      }
    }
  }
}
