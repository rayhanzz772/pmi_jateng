import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model untuk RoomType
class RoomType {
  final int id;
  final String roomType;
  final int capacity;
  final double price;
  final String description;
  final String image;

  RoomType({
    required this.id,
    required this.roomType,
    required this.capacity,
    required this.price,
    required this.description,
    required this.image,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) {
    return RoomType(
      id: json['id'],
      roomType: json['room_type'],
      capacity: json['capacity'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'],
      image: json['image'],
    );
  }
}

// Base URL dari API Laravel
const String baseUrl = 'http://localhost:8000'; // Gunakan IP address lokal Anda

// Fungsi untuk mengambil data RoomType dari API
Future<List<RoomType>> fetchRoomTypes() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/api/room_type/getAll'));

    // Print status code dan response body untuk debugging
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      // Debugging: Print setiap item dalam JSON response
      for (var item in jsonResponse) {
        print('JSON item: $item');
      }

      return jsonResponse.map((data) => RoomType.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load room types');
    }
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}

// Widget untuk menampilkan daftar RoomType
class RoomTypeList extends StatefulWidget {
  @override
  _RoomTypeListState createState() => _RoomTypeListState();
}

class _RoomTypeListState extends State<RoomTypeList> {
  late Future<List<RoomType>> futureRoomTypes;

  @override
  void initState() {
    super.initState();
    futureRoomTypes = fetchRoomTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Types'),
      ),
      body: Center(
        child: FutureBuilder<List<RoomType>>(
          future: futureRoomTypes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data found');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final roomType = snapshot.data![index];
                  return ListTile(
                    title: Text(roomType.roomType),
                    subtitle: Text(
                        '${roomType.capacity} people\n\$${roomType.price}\n${roomType.description}'),
                    leading: Image.asset(roomType.image, fit: BoxFit.cover),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
