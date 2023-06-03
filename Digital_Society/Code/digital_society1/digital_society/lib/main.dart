// ignore_for_file: unused_import

import 'package:digital_society/onBoarding.dart';
import 'package:digital_society/screens/homepage.dart';
import 'package:digital_society/screens/loginpage.dart';
import 'package:digital_society/screens/memberpage.dart';
//import 'package:digital_society/screens/homepage.dart';
//import 'package:digital_society/screens/loginpage.dart';
//import 'package:digital_society/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.dmSans().fontFamily),
      debugShowCheckedModeBanner: false,
      home: const onBoardingScreen(),
    );
  }
}
