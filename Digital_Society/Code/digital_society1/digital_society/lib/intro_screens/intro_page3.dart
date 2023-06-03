import 'package:digital_society/screens/loginpage.dart';
//import 'package:digital_society/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import '../login_signup/welcome_screen.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
                      fit: BoxFit.fill,
                      // alignment: Alignment.center,
                      // scale: 2,
                      image: AssetImage(
                        'assets/images/3.gif',
                      ))),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "It is the gateway to an enhanced",
                style: TextStyle(
                    fontSize: 20,
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
                " digital society within your  ",
                style: TextStyle(
                    fontSize: 20,
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
                "residential space.",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: GoogleFonts.dmSans().fontFamily,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginView();
              }));
            },
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
