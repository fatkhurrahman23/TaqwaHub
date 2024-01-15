import 'package:flutter/material.dart';
import 'pilihan_menu.dart';

class MulaiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TAQWA HUB'),
        automaticallyImplyLeading: false,
        backgroundColor:
            Colors.green, // Ganti warna latar belakang AppBar menjadi hijau
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Menentukan tinggi melengkungnya
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://www.man1sragen.sch.id/wp-content/uploads/2019/11/mosque-png-45523.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Selamat datang di Aplikasi Taqwa Hub!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PilihanMenu()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors
                    .green, // Ganti warna latar belakang button menjadi hijau
              ),
              child: Text(
                'Masuk',
                style: TextStyle(
                  color: Colors.white, // Ganti warna teks button menjadi putih
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
