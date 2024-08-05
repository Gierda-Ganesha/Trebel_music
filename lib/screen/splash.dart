import 'package:flutter/material.dart';
import 'package:music/screen/login_page.dart'; // Sesuaikan dengan path yang benar
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Bungkus body dengan Container
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Gradien mulai dari pojok kiri atas
            end: Alignment.bottomRight, // Gradien berakhir di pojok kanan bawah
            colors: [
              Color(0xFF0d3144), // Warna biru tua
              Color(0xFF425e67), // Warna biru keabuan
              Color(0xFF748f8d), // Warna abu-abu kehijauan
              Color(0xFFa8c3b4), // Warna hijau muda
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Make Your Day',
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              SpinKitDoubleBounce(
                color: Colors.white,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
