import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class SholatScreen extends StatefulWidget {
  @override
  _SholatScreenState createState() => _SholatScreenState();
}

class _SholatScreenState extends State<SholatScreen> {
  String _selectedCity = 'Semarang';
  late Future<Map<String, dynamic>> _schedule; // Change the type of _schedule

  @override
  void initState() {
    super.initState();
    _schedule = fetchSchedule(_selectedCity); // Remove unnecessary cast
  }

  Future<Map<String, dynamic>> fetchSchedule(String city) async {
    final DateTime now = DateTime.now();
    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(now); // Format date to 'yyyy-MM-dd'
    String formattedMonth = now.month.toString().padLeft(2, '0');
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/${city.toLowerCase()}/${now.year}/${formattedMonth}.json'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      Map<String, dynamic> tanggalData = data.firstWhere((item) =>
          item['tanggal'] ==
          formattedDate); // Find the data for the current date
      return tanggalData;
    } else {
      return {
        'error': 'Failed to load schedule',
        'status_code': response.statusCode
      };
      // throw Exception('Failed to load schedule');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Sholat'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.lightGreen,
                    Colors.green
                  ], // Warna gradien pulau
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: _selectedCity,
                        items: <String>[
                          'Semarang',
                          'Yogyakarta',
                          'Jakarta',
                          'Bandung',
                          'Surabaya'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCity = value!;
                            _schedule = fetchSchedule(
                                _selectedCity); // Update the schedule when the city is changed
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.location_on),
                      SizedBox(
                          width:
                              8), // Add some space between the icon and the text
                      Text(_selectedCity, style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  Text(
                    '${DateFormat('HH:mm').format(DateTime.now())}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FractionallySizedBox(
              // heightFactor: 0.6,
              child: FutureBuilder<Map<String, dynamic>>(
                future: _schedule,
                builder: (context, snapshot) {
                  print('Snapshot state: ${snapshot.connectionState}');
                  if (snapshot.hasData) {
                    return ListView(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.nights_stay_outlined),
                          title: Text('Imsak'),
                          trailing: Text(snapshot.data!['imsyak']),
                        ),
                        ListTile(
                          leading: Icon(Icons.filter_drama_outlined),
                          title: Text('Subuh'),
                          trailing: Text(snapshot.data!['shubuh']),
                        ),
                        ListTile(
                          leading: Icon(Icons.wb_twilight_outlined),
                          title: Text('Terbit'),
                          trailing: Text(snapshot.data!['terbit']),
                        ),
                        ListTile(
                          leading: Icon(Icons.wb_sunny_outlined),
                          title: Text('Dhuha'),
                          trailing: Text(snapshot.data!['dhuha']),
                        ),
                        ListTile(
                          leading: Icon(Icons.wb_sunny),
                          title: Text('Dzuhur'),
                          trailing: Text(snapshot.data!['dzuhur']),
                        ),
                        ListTile(
                          leading: Icon(Icons.brightness_medium_outlined),
                          title: Text('Ashar'),
                          trailing: Text(snapshot.data!['ashr']),
                        ),
                        ListTile(
                          leading: Icon(Icons.brightness_low_outlined),
                          title: Text('Maghrib'),
                          trailing: Text(snapshot.data!['magrib']),
                        ),
                        ListTile(
                          leading: Icon(Icons.dark_mode),
                          title: Text('Isya'),
                          trailing: Text(snapshot.data!['isya']),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
