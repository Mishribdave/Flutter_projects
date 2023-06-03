import 'package:digital_society/intro_screens/intro_page1.dart';
import 'package:digital_society/intro_screens/intro_page2.dart';
import 'package:digital_society/intro_screens/intro_page3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  PageController smooth_page_controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: smooth_page_controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [IntroPage1(), IntroPage2(), IntroPage3()],
        ),
        Positioned(
          top: 730,
          //  left: 85,
          child: Container(
              width: 350,
              alignment: Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      smooth_page_controller.jumpToPage(2);
                    },
                    child: Container(
                      height: 35,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        //  color: Colors.black
                      ),
                      child: Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.dmSans().fontFamily),
                        ),
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                      controller: smooth_page_controller, count: 3),
                  onLastPage
                      ? Container(
                          height: 35,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          // child: Center(
                          //   child: Text(
                          //     "",
                          //     style: TextStyle(
                          //         fontSize: 20,
                          //         color: Colors.black,
                          //         fontWeight: FontWeight.bold,
                          //         fontFamily:
                          //             GoogleFonts.dmSans().fontFamily),
                          //   ),
                          // ),
                        )
                      : GestureDetector(
                          onTap: () {
                            smooth_page_controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Container(
                            height: 35,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.dmSans().fontFamily),
                              ),
                            ),
                          ),
                        ),
                ],
              )),
        )
      ]),
    );
  }
}
