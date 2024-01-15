import 'package:flutter/material.dart';
import 'package:flutter_application_islami/alquran_screen.dart';
import 'package:flutter_application_islami/sholat_screen.dart';
import 'package:flutter_application_islami/doa_screen.dart';

class PilihanMenu extends StatefulWidget {
  @override
  _PilihanMenuState createState() => _PilihanMenuState();
}

class _PilihanMenuState extends State<PilihanMenu> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //title: Text(''),
      //),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return AlQuranScreen();
      case 1:
        return SholatScreen();
      case 2:
        return DoaScreen();
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Al-Quran',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Jadwal Sholat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Doa',
        ),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
