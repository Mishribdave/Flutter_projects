// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:digital_society/screens/memberpage.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:digital_society/screens/homepage.dart';

class Society {
  String? name;
  String? contact;
  String? house;
  String? pic;
  String? role;
  Society({
    this.name,
    this.contact,
    this.house,
    this.pic,
    this.role,
  });

  factory Society.fromMap(Map<String, dynamic> map) {
    return Society(
      name: map['name'],
      contact: map['contact'],
      house: map['house'],
      pic: map['pic'],
      role: map['role'],
    );
  }
}

Future<bool> fetchData(String contact, String role, String password) async {
  var response = await http.get(Uri.parse(
      "https://mishriflutter.000webhostapp.com/DigitalSociety/fetch_digital_society.php?contact=$contact&&role=$role&&password=$password"));
  var data = json.decode(response.body);

  if (response.statusCode == 200 && data.isNotEmpty) {
    // Login successful
    return true;
  } else {
    // Login failed
    return false;
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String role = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                SvgPicture.asset(
                  "assets/images/login_view.svg",
                  height: 200,
                ),
                Spacer(),
                Container(
                    height: 100,
                    child: TextField(
                      controller: contactcontroller,
                      decoration:
                          InputDecoration(hintText: "Enter Phone number"),
                    )),
                Container(
                    height: 100,
                    child: TextField(
                      controller: passwordcontroller,
                      decoration: InputDecoration(hintText: "Enter Password"),
                    )),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: "chairmen",
                        title: Text("chairman"),
                        groupValue: role,
                        onChanged: (value) {
                          setState(() {
                            role = value.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                          value: "member",
                          title: Text("member"),
                          groupValue: role,
                          onChanged: (value) {
                            setState(() {
                              role = value.toString();
                            });
                          }),
                    ),
                  ],
                ),

                MaterialButton(
                  onPressed: () async {
                    String contact = contactcontroller.text.toString();
                    String password = passwordcontroller.text.toString();
                    if (contact.isNotEmpty && password.isNotEmpty) {
                      bool loginStatus =
                          await fetchData(contact, role, password);
                      if (loginStatus) {
                        if (role == "chairmen") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemberHomePage(membername: contact),
                            ),
                          );
                        }
                      }
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return
                      //     //  AlertDialog(
                      //     //   title: Text('Login Successful'),
                      //     //   content: Text('You have successfully logged in.'),
                      //     //   // actions: [
                      //     //   //   TextButton(
                      //     //   //     child: Text('OK'),
                      //     //   //     onPressed: () {
                      //     //   //       Navigator.of(context).pop();
                      //     //   //     },
                      //     //   //   ),
                      //     //   // ],
                      //     // );
                      //   },
                      // );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Login Failed'),
                            content: Text('Invalid login credentials.'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  minWidth: double.infinity,
                  color: Color.fromARGB(255, 33, 32, 32),
                  height: 60,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.dmSans().fontFamily,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("Don't have an account?"),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     InkWell(
                //         onTap: () {
                //            Navigator.push(context, MaterialPageRoute(
                //             builder: (context) {
                //               return SignupView();
                //             },
                //           ));
                //         },
                //         child: Text(
                //           "Sign Up",
                //           style: TextStyle(fontWeight: FontWeight.w600),
                //         )),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget makeInput({label, obsureText = false,phonenumcontroller}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(
  //             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
  //       ),
  //       SizedBox(
  //         height: 5,
  //       ),
  //       TextField(
  //       controller: phonenumcontroller,
  //         obscureText: obsureText,
  //         decoration: InputDecoration(
  //           contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Colors.grey,
  //             ),
  //           ),
  //           border:
  //               OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 20,
  //       )
  //     ],
  //   );
  // }
}
