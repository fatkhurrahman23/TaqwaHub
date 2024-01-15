import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:google_fonts/google_fonts.dart';

class SurahPage extends StatefulWidget {
  final String surahNumber;

  SurahPage(this.surahNumber);

  @override
  _SurahPageState createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  Future<List<dynamic>> fetchSurahDetails() async {
    final response = await http.get(Uri.parse(
        'https://api.npoint.io/99c279bb173a6e28359c/surat/${widget.surahNumber}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load surah details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat dan Artinya'),
        backgroundColor:
            Colors.green, // Ganti warna latar belakang AppBar menjadi hijau
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Menentukan tinggi melengkungnya
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchSurahDetails(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Text(
                        snapshot.data[index]['nomor'],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .black, // Ganti warna teks nomor surah menjadi hijau
                        ),
                      ),
                      title: Text(
                        snapshot.data[index]['ar'],
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        snapshot.data[index]['id'],
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors
                              .brown, // Ganti warna teks terjemahan menjadi hijau
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Divider(
                      color: Colors.green, // Ganti warna divider menjadi hijau
                    ), // Add this line
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
