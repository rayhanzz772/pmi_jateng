import 'package:http/http.dart' as http;
import 'dart:convert';
import 'room_type.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.5:8000/api/room_type";

  static Future<List<RoomType>> fetchRoomTypes() async {
    final response = await http.get(Uri.parse("$baseUrl/getAll"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData.map((json) => RoomType.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load room types');
    }
  }

  static Future<RoomType> fetchRoomTypeById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/getDetail?id=$id"));

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
}
