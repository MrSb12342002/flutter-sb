import 'package:flutter/material.dart';
import 'package:saavn_music_player/home.dart';

void main() {
  runApp(const SaavnApp());
}

class SaavnApp extends StatelessWidget {
  const SaavnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(),
      ),
      home: const HomeScreen(),
    );
  }
}
