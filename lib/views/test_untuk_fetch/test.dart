import 'package:flutter/material.dart';
import 'package:pmi_jateng/service/api_service.dart';

class TestApiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Map<String, dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = ApiService().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Demo'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            } else {
              var roomList = snapshot.data!['room_data'] as List;
              return ListView.builder(
                itemCount: roomList.length,
                itemBuilder: (context, index) {
                  var roomData = roomList[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            roomData['image'] ??
                                'https://via.placeholder.com/200', // Default image if null
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 16.0),
                          ListTile(
                            title: Text('Room Type'),
                            subtitle: Text(roomData['room_type'] ?? 'N/A'),
                          ),
                          ListTile(
                            title: Text('Capacity'),
                            subtitle:
                                Text(roomData['capacity']?.toString() ?? 'N/A'),
                          ),
                          ListTile(
                            title: Text('Price'),
                            subtitle: Text('IDR ${roomData['price'] ?? 'N/A'}'),
                          ),
                          ListTile(
                            title: Text('Description'),
                            subtitle: Text(roomData['description'] ?? 'N/A'),
                          ),
                        ],
                      ),
                    ),
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
