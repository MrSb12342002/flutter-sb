import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 950,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Hey',
                          style: GoogleFonts.montserrat(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 800,
                        ),
                        const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.sunny,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'I am Sukanta Behera',
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
