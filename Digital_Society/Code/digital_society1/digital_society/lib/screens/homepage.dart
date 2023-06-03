// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import "package:digital_society/screens/loginpage.dart";
import "package:digital_society/screens/view_complaint.dart";
import "package:digital_society/screens/viewmembers.dart";
//import "package:digital_society/screens/welcome.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController charges_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController mobile_number = TextEditingController();
  TextEditingController house_no = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController event_name = TextEditingController();
  TextEditingController event_date = TextEditingController();
  TextEditingController event_desc = TextEditingController();
  TextEditingController add_notice_controller = TextEditingController();
  TextEditingController notice_subject_controller = TextEditingController();

  String url =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/insert_digital_society.php";

  String eventurl =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/fetch_event.php";

  String postUrl =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/insert_event.php";

  String postnoticeurl =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/insert_notice.php";

  String fetchnoticeurl =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/fetch_notice.php";

  String setchargesurl =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/insert_charges.php";

  String fetchchargesurl =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/fetch_charges.php";

  postSocietyMember(
      String name, String number, String houseno, String password) async {
    var postdata = await http.post(Uri.parse(url), body: {
      "name": name,
      "contact": number,
      "house": houseno,
      "role": "member",
      "password": password
    });
    print(postdata.body);
  }

  postcharges(String charges) async {
    var chargesresponse =
        await http.post(Uri.parse(setchargesurl), body: {"charges": charges});
    print(chargesresponse.body);
  }

  Future<List<EventModel>> fetchevent() async {
    var eventresponse = await http.get(Uri.parse(eventurl));

    if (eventresponse.statusCode == 200) {
      final List eventlist = json.decode(eventresponse.body);
      return eventlist.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception("invalid data");
    }
  }

  Future<List<NoticeModel>> fetchnotice() async {
    var noticeresponse = await http.get(Uri.parse(fetchnoticeurl));

    if (noticeresponse.statusCode == 200) {
      final List noticelist = json.decode(noticeresponse.body);
      return noticelist.map((e) => NoticeModel.fromJson(e)).toList();
    } else {
      throw Exception("invalid data");
    }
  }

  postEvent(String eventname, String datevar, String eventdesc) async {
    var postevent = await http.post(Uri.parse(postUrl), body: {
      "event_name": eventname,
      "event_date": datevar,
      "event_desc": eventdesc
    });
    print(postevent.body);
  }

  postNotice(String notice_subject, String notice_description) async {
    var postnotice = await http.post(Uri.parse(postnoticeurl), body: {
      "notice_subject": notice_subject,
      "notice_description": notice_description
    });
    print(postnotice.body);
  }

  Future<List<Chargemodel>> fetchcharges() async {
    var fetchchargesresponse = await http.get(Uri.parse(fetchchargesurl));
    if (fetchchargesresponse.statusCode == 200) {
      final List chargelist = json.decode(fetchchargesresponse.body);
      print(json.decode(fetchchargesresponse.body));
      return chargelist.map((e) => Chargemodel.fromJson(e)).toList();
    } else {
      throw Exception("Invalid data");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width_m = MediaQuery.of(context).size.width;
    final height_m = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              height: height_m * 0.35,
              width: width_m,
              child: Container(
                color: Color.fromARGB(255, 33, 32, 32),
              )),
          Positioned(
            left: width_m * 0.20,
            top: height_m * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome Chairman",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(width: 28),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginView();
                      },
                    ));
                  },
                  child: Icon(
                    Icons.exit_to_app_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 100,),
          //Text("Complaints", style: TextStyle(color: Colors.white),),
          Positioned(
            height: 225,
            width: width_m * 0.9,
            top: height_m * 0.15,
            left: width_m * 0.05,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      transform: GradientRotation(0.1),
                      colors: [
                        Color.fromARGB(255, 222, 202, 225),
                        Color.fromARGB(255, 50, 50, 50)
                      ])),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Maintanence Charges",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Brooklyn Apartment",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: height_m * 0.35,
                                    width: width_m * 0.35,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: AlertDialog(
                                      title: Text(
                                        "Set maintenance charges",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 91, 66, 95),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: GoogleFonts.roboto()
                                                .fontFamily),
                                      ),
                                      content: TextFormField(
                                        controller: charges_controller,
                                        onChanged: (value) {},
                                        decoration: InputDecoration(
                                          //  fillColor: Colors.purple.shade100,
                                          hintText: "Enter charges",
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                postcharges(charges_controller
                                                    .text
                                                    .toString());
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              "SET",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 91, 66, 95),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  fontFamily:
                                                      GoogleFonts.roboto()
                                                          .fontFamily),
                                            ))
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            "Set Charges",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(94, 255, 255, 255)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          child: FutureBuilder(
                            future: fetchcharges(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Chargemodel> chargesdata = snapshot.data!;
                                return ListView.builder(
                                  padding: EdgeInsets.only(top: 0),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text(
                                      "₹ " + chargesdata[index].charges!,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),

                        //  Text(
                        //   " ₹350",
                        //   style: TextStyle(fontSize: 20, color: Colors.white),
                        // ),

                        // )

                        //  SizedBox(height: 5),

                        Text(
                          "09 oct",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 330.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Members",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewMember(),
                                )),
                            child: Container(
                              height: 50,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black),
                              child: Center(
                                child: Text(
                                  "Tap to view",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30)),
                              width: 170,
                              height: 50,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                View_complaints(),
                                          ));
                                    });
                                   
                                  },
                                  child: Text(
                                    "View Complaints",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        height: 550,
                                        width: 300,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 15),
                                            Container(
                                                height: 150,
                                                width: 150,
                                                child: Image.asset(
                                                  "assets/images/avatr.jpg",
                                                )),
                                            SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Text("Add a Society member",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            GoogleFonts.dmSans()
                                                                .fontFamily)),
                                                SizedBox(width: 90),
                                                InkWell(
                                                  onTap: () {
                                                    postSocietyMember(
                                                      name_controller.text
                                                          .toString(),
                                                      mobile_number.text
                                                          .toString(),
                                                      house_no.text.toString(),
                                                      password.text.toString(),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            GoogleFonts.dmSans()
                                                                .fontFamily),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            Flexible(
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  height: 330,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          hintText: "Mishri",
                                                          labelText:
                                                              "Enter Name",
                                                          prefixIcon: Icon(
                                                            Icons.person,
                                                            //color: Colors.deepPurple,
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Enter Name";
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            name_controller,
                                                      ),
                                                      SizedBox(height: 20),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          hintText:
                                                              "9875241201",
                                                          labelText:
                                                              "Enter number",
                                                          prefixIcon: Icon(
                                                            Icons.contact_phone,
                                                            // color: Colors.orangeAccent,
                                                          ),
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            mobile_number,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Enter Name";
                                                          }
                                                          if (mobile_number.text
                                                                  .length !=
                                                              10) {
                                                            return "Please enter valid mobile number";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      SizedBox(height: 20),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          hintText: "12",
                                                          labelText:
                                                              "Enter house no",
                                                          prefixIcon: Icon(
                                                            Icons
                                                                .house_outlined,
                                                            //   color: Colors.green,
                                                          ),
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller: house_no,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Enter house number";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      SizedBox(height: 20),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          hintText: "abc123",
                                                          labelText:
                                                              "Enter Password",
                                                          prefixIcon: Icon(
                                                            Icons.lock,
                                                            //   color: Colors.green,
                                                          ),
                                                        ),
                                                        //keyboardType: TextInputType.number,
                                                        controller: password,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Enter password";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text(
                              "Add Member +",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notices",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        height: 750,
                                        width: 300,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 15),
                                            Container(
                                                height: 150,
                                                width: 200,
                                                child: Image.network(
                                                  "https://www.trafficsigns.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/w/1/w16-18-notice.png",
                                                )),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text("Add a Notice",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            GoogleFonts.dmSans()
                                                                .fontFamily)),
                                                SizedBox(width: 160),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      postNotice(
                                                          notice_subject_controller
                                                              .text
                                                              .toString(),
                                                          add_notice_controller
                                                              .text
                                                              .toString());
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text(
                                                    "Add",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            GoogleFonts.dmSans()
                                                                .fontFamily),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            Flexible(
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  height: 330,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          hintText:
                                                              "Maintenance",
                                                          labelText:
                                                              "Add Subject",
                                                          prefixIcon: Icon(
                                                            Icons.subject,
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Add Subject";
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            notice_subject_controller,
                                                      ),
                                                      SizedBox(height: 20),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          hintText:
                                                              "This is to inform you",
                                                          labelText:
                                                              "Enter notice",
                                                          prefixIcon: Icon(
                                                            Icons
                                                                .info_outline_rounded,
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return "Enter notice";
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            add_notice_controller,
                                                      ),
                                                      SizedBox(height: 20),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Add Notice +",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: const [
                    //       Text(
                    //         "Notice Header",
                    //         style: TextStyle(fontSize: 25),
                    //       ),
                    //       Icon(Icons.notification_important)
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {},
                    //         child: Text(
                    //           "timings and date",
                    //           style: TextStyle(fontSize: 20),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Container(
                      height: 100,
                      child: FutureBuilder(
                        future: fetchnotice(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<NoticeModel> noticedata = snapshot.data!;
                            return ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            noticedata[index].noticesubject!,
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          Icon(Icons.notification_important)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Text(
                                              noticedata[index]
                                                  .noticedescription!,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    Divider(
                      thickness: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Events",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          //color: Colors.green[50],
                                          //  color: Colors.blue,
                                          height: 750,
                                          width: 300,
                                          child: Column(
                                            children: [
                                              Container(
                                                  height: 100,
                                                  width: 350,
                                                  child: Image.network(
                                                    "https://www.shutterstock.com/image-vector/events-letters-banner-260nw-1186787812.jpg",
                                                    fit: BoxFit.cover,
                                                  )),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Add event",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .dmSans()
                                                                  .fontFamily)),
                                                  SizedBox(width: 90),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        postEvent(
                                                            event_name.text
                                                                .toString(),
                                                            event_date.text
                                                                .toString(),
                                                            event_desc.text
                                                                .toString());
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .dmSans()
                                                                  .fontFamily),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Flexible(
                                                child: SingleChildScrollView(
                                                  child: Container(
                                                    height: 300,
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            hintText:
                                                                "Festival",
                                                            labelText:
                                                                "Enter Event Name",
                                                            prefixIcon: Icon(
                                                              Icons.event,
                                                            ),
                                                          ),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Enter Event Name";
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              event_name,
                                                        ),
                                                        SizedBox(height: 20),
                                                        TextField(
                                                          controller:
                                                              event_date,
                                                          decoration:
                                                              InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            labelText:
                                                                "Select date",
                                                            prefixIcon: Icon(Icons
                                                                .calendar_today_rounded),
                                                          ),
                                                          onTap: () async {
                                                            DateTime?
                                                                pickeddate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            200),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2025));
                                                            if (pickeddate !=
                                                                null) {
                                                              setState(() {
                                                                event_date
                                                                    .text = DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        pickeddate);
                                                              });
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(height: 20),
                                                        TextFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            hintText:
                                                                "This event is about Navratri Celebration",
                                                            labelText:
                                                                "Add Description",
                                                            prefixIcon: Icon(
                                                              Icons.description,
                                                            ),
                                                          ),
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Add Description";
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              event_desc,
                                                        ),
                                                        SizedBox(height: 20),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Add Events +",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      child: FutureBuilder(
                        future: fetchevent(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<EventModel> eventdata = snapshot.data!;
                            return ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            eventdata[index].eventname!,
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          Icon(Icons.notification_important)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: width_m * 0.9,
                                              child: Text(
                                                eventdata[index]
                                                    .eventdescription!,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
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

class EventModel {
  String? eventname;
  String? eventdate;
  String? eventdescription;
  EventModel({
    this.eventname,
    this.eventdate,
    this.eventdescription,
  });

  factory EventModel.fromJson(Map<String, dynamic> map) {
    return EventModel(
      eventname: map['event_name'],
      eventdate: map['event_date'],
      eventdescription: map['event_desc'],
    );
  }
}

class NoticeModel {
  String? noticesubject;
  String? noticedescription;
  NoticeModel({
    this.noticesubject,
    this.noticedescription,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> map) {
    return NoticeModel(
      noticesubject: map['notice_subject'],
      noticedescription: map['notice_description'],
    );
  }
}

class Chargemodel {
  String? charges;
  Chargemodel({
    this.charges,
  });

  factory Chargemodel.fromJson(Map<String, dynamic> map) {
    return Chargemodel(
      charges: map['charges'],
    );
  }
}
