//frontend\sway\lib\screens\splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the Home screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFEF9), // Background color
      body: Center(
        child: Text(
          'Sway',
          style: TextStyle(
            fontFamily: 'Gistesy', // Use the Gistesy font here
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF122620), // Text color
          ),
        ),
      ),
    );
  }
}
