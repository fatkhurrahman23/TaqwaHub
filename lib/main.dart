// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_islami/mulai_screen.dart';
import 'package:flutter_application_islami/splash_screen.dart';
// import 'package:flutter_application_islami/alquran_screen.dart';
// import 'package:flutter_application_islami/pilihan_menu.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => MulaiScreen(),
      },
    );
  }
}
