import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 600,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/2.gif'))),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Digital Society fosters a sense of ",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "community by providing a platform for ",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "residents to connect. Stay updated ",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "with local events, and community ",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "initiatives to actively participate in ",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "shaping your digital society.",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
