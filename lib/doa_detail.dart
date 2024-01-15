import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchDoaDetail(int id) async {
  final response =
      await http.get(Uri.parse('https://open-api.my.id/api/doa/$id'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load doa detail');
  }
}

class DoaDetailPage extends StatelessWidget {
  final int id;

  DoaDetailPage({required Key key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doa dan Terjemah'),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Menentukan tinggi melengkungnya
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDoaDetail(id),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                    color: Colors.red), // Ganti warna teks menjadi merah
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      snapshot.data!['arab'],
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black, // Ganti warna teks menjadi hijau
                      ),
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      snapshot.data!['terjemah'],
                      style: TextStyle(fontSize: 12.0, color: Colors.brown),
                    ),
                  ),
                  Divider(
                    color:
                        Colors.green, // Ganti warna garis pemisah menjadi hijau
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
