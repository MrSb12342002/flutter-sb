import 'package:flutter/material.dart';
import 'package:ui_practice/where_is_my_train/screens/where_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WhereHome(),
    );
  }
}
