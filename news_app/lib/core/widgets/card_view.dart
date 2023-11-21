import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          // Image.network("hdfh"),
          Text('titel'),
        ],
      ),
    );
  }
}
