import 'package:flutter/material.dart';
import 'package:spacebook/Homepage.dart';
import 'package:spacebook/auth_screen.dart';
import 'package:spacebook/splash.dart';

void main() {
  runApp(const SpaceBookApp());
}

class SpaceBookApp extends StatelessWidget {
  const SpaceBookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF3D7F1E),
      ),
      home: HomePage(),
    );
  }
}

