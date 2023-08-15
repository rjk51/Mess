import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});
  @override
  Widget build(context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          "assets/images/logo.png",
          width: 500,
          height: 500,
        ),
        const SizedBox(height: 20),
        Text('"Mess"',
            style: GoogleFonts.bangers(
                textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 50,
            ))),
        const SizedBox(height: 90),
        Text('~by Ayaan Rajak',
            style: GoogleFonts.robotoCondensed(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ))
      ]),
    );
  }
}
