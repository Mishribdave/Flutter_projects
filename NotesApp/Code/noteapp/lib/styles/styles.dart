import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class styleapp {
  static Color bgColor = Color(0xffe2e2ff);
  static Color mainColor = Color.fromARGB(255, 0, 1, 52);
  static Color accentColor = Color(0xff0065FF);

  //give different colours to cards
  static List<Color> cardsColor = [
    Colors.white,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
    Colors.deepPurple.shade100,
    Colors.tealAccent.shade100
  ];

  //text styles
  static TextStyle mainTitle = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mainContent = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static TextStyle dateTitle = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
}
