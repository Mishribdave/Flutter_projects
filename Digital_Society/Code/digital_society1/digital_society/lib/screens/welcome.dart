import 'package:digital_society/screens/loginpage.dart';
import 'package:digital_society/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class welcome_page extends StatelessWidget {
  const welcome_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.dmSans().fontFamily),
            ),
            SizedBox(height: 20),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                // width: MediaQuery.of(context).size.width * 0.6,
                child: SvgPicture.asset("assets/images/devloper.svg")),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Color(0xff6C63FF)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginView();
                    },
                  ));
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 0),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Color(0xff535461)),
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SignupView();
                    },
                  ));
                },
                child: Text(
                  "Signup",
                  style: TextStyle(
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
