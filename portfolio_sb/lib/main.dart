import 'package:flutter/material.dart';
import 'package:portfolio_sb/portfolio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData.dark(),
      home: const PortfolioApp(),
    );
  }
}
