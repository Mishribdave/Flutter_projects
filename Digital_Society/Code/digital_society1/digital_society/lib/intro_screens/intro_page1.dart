import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

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
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/1.gif'))),
              //   child: (Image.asset('assets/images/1.gif', fit: BoxFit.cover,)),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Digital",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.dmSans().fontFamily),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Society",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.dmSans().fontFamily),
              ),
            ],
          ),
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Our app is your go-to companion for ",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "managing and optimizing various aspects",
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
                "  of your home and lifestyle.",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
