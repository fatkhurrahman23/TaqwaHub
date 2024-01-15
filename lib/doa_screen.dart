import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_islami/doa_detail.dart';
import 'package:http/http.dart' as http;

class DoaScreen extends StatefulWidget {
  @override
  _DoaScreenState createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  List _doas = [];

  @override
  void initState() {
    super.initState();
    fetchDoas();
  }

  Future<List<dynamic>> fetchDoas() async {
    final response =
        await http.get(Uri.parse('https://open-api.my.id/api/doa'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // throw Exception('Failed to load doas');
      return [response.statusCode];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doa Harian'),
        backgroundColor:
            Colors.green, // Ganti warna latar belakang AppBar menjadi hijau
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Menentukan tinggi melengkungnya
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: fetchDoas(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors
                              .blueGrey, // Ganti warna latar belakang avatar menjadi hijau
                          child: Text(
                            snapshot.data[index]['id'].toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors
                                  .white, // Ganti warna teks menjadi putih
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoaDetailPage(
                                key: Key('doa_detail'),
                                id: snapshot.data[index]['id'],
                              ),
                            ),
                          );
                        },
                        title: Text(snapshot.data[index]['judul']),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
