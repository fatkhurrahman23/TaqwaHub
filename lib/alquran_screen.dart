import 'package:flutter/material.dart';
// import 'search_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_islami/surah_page.dart';

class AlQuranScreen extends StatefulWidget {
  @override
  _AlQuranScreenState createState() => _AlQuranScreenState();
}

class _AlQuranScreenState extends State<AlQuranScreen> {
  List<dynamic> _surahs = [];
  List<dynamic> _filteredSurahs = [];

  Future<List<dynamic>> fetchSurahs() async {
    final response = await http
        .get(Uri.parse('https://api.npoint.io/99c279bb173a6e28359c/data'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load surahs');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSurahs().then((surahs) {
      setState(() {
        _surahs = surahs;
        _filteredSurahs = surahs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Al-Quran dan Terjemah'),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Menentukan tinggi melengkungnya
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _filteredSurahs = _surahs.where((surah) {
                    return surah['nama']
                        .toLowerCase()
                        .contains(value.toLowerCase());
                  }).toList();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: fetchSurahs(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _filteredSurahs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Text(
                          _filteredSurahs[index]['nomor'],
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        title: Text(
                          _filteredSurahs[index]['nama'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        subtitle: Text(
                          '${_filteredSurahs[index]['arti']}, Ayat: ${_filteredSurahs[index]['ayat']}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        trailing: Text(
                          _filteredSurahs[index]['asma'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SurahPage(_filteredSurahs[index]['nomor']),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.green,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
