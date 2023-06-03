import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/welcome_screen.dart';

void main() {
  runApp(travelapp());
}

class travelapp extends StatefulWidget {
  const travelapp({super.key});

  @override
  State<travelapp> createState() => _travelappState();
}

class _travelappState extends State<travelapp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
