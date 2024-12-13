import 'package:flutter/material.dart';
import 'package:flutter_application_1/photo_guidelines_screen.dart';
import 'package:flutter_application_1/scan_screen.dart';
import 'package:flutter_application_1/select_screen.dart';
import 'package:flutter_application_1/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skin Burn App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const StartScreen(),
      routes: {
        '/start': (context) => const StartScreen(),
        '/photo-guidelines': (context) => const PhotoGuidelinesScreen(),
        '/scan': (context) => const ScanScreen(),
        '/select': (context) => const SelectScreen(),
      },
    );
  }
}
