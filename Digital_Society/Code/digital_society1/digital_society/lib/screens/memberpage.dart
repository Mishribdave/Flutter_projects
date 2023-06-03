// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unused_local_variable
import "dart:convert";

import "package:digital_society/screens/homepage.dart";
import "package:digital_society/screens/loginpage.dart";
import "package:digital_society/screens/viewmembers.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:http/http.dart' as http;

class MemberHomePage extends StatefulWidget {
  String? membername;
  MemberHomePage({
    super.key,
    required this.membername,
  });

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}

String eventurl =
    "https://mishriflutter.000webhostapp.com/DigitalSociety/fetch_event.php";

String fetchnoticeurl =
    "https://mishriflutter.000webhostapp.com/DigitalSociety/fetch_notice.php";
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

Future<List<MemberModel>> fetchmember(String contact) async {
  var noticeresponse = await http.get(Uri.parse(
      "https://mishriflutter.000webhostapp.com/DigitalSociety/fetchspecificmember.php?contact=$contact"));

  if (noticeresponse.statusCode == 200) {
    final List memberlist = json.decode(noticeresponse.body);
    print(noticeresponse.body);
    return memberlist.map((e) => MemberModel.fromJson(e)).toList();
  } else {
    throw Exception("invalid data");
  }
}

class _MemberHomePageState extends State<MemberHomePage> {
  String complainturl =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/insert_complaint.php";

  String fetchchargesurl =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/fetch_charges.php";

  postcomplain(
    String complaint_subject,
    String complaint_desc,
    String contact,
  ) async {
    var complainresponse = await http.post(Uri.parse(complainturl), body: {
      "complaint_subject": complaint_subject,
      "complaint_desc": complaint_desc,
      "contact": contact
    });
    print(complainresponse.body);
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

  TextEditingController add_subject = TextEditingController();
  TextEditingController add_complaints = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? member = widget.membername;
    final width_m = MediaQuery.of(context).size.width;
    final height_m = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        Positioned(
            height: height_m * 0.35,
            width: width_m,
            child: Container(
              color: Color.fromARGB(255, 33, 32, 32),
            )),
        Positioned(
          left: width_m * 0.25,
          top: height_m * 0.07,
          child: Row(
            children: [
              Icon(
                Icons.maps_home_work_sharp,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Residence",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 50,
              ),
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
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
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
                      const Color.fromARGB(255, 50, 50, 50)
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
                      Text(
                        "Upcoming Charges",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(94, 255, 255, 255)),
                      ),
                      Text(
                        "Due",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(94, 255, 255, 255)),
                      )
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
                                  return Row(
                                    children: [
                                      Text(
                                        "₹ " + chargesdata[index].charges!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              fetchcharges();
                                            });
                                          },
                                          child: Icon(
                                            Icons.refresh,
                                            color: Colors.white,
                                          ))
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         " ₹350",
                //         style: TextStyle(fontSize: 20, color: Colors.white),
                //       ),
                //       Text(
                //         "09 oct",
                //         style: TextStyle(fontSize: 20, color: Colors.white),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 350.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Show members",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )
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
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20)),
                                                    height: 150,
                                                    width: 350,
                                                    child: Image.network(
                                                      "https://img.etimg.com/thumb/msid-93229764,width-300,height-225,imgsize-510277,,resizemode-75/complaint.jpg",
                                                    )),
                                                SizedBox(height: 20),
                                                Row(
                                                  children: [
                                                    Text("Add a Complaint",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontFamily: GoogleFonts
                                                                    .dmSans()
                                                                .fontFamily)),
                                                    SizedBox(width: 140),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          postcomplain(
                                                              add_subject.text
                                                                  .toString(),
                                                              add_complaints
                                                                  .text
                                                                  .toString(),
                                                              widget
                                                                  .membername
                                                                  .toString());
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child: Text(
                                                        "Add",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontFamily: GoogleFonts
                                                                    .dmSans()
                                                                .fontFamily),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 30),
                                                Flexible(
                                                  child:
                                                      SingleChildScrollView(
                                                    child: Container(
                                                      height: 330,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          20)),
                                                              hintText:
                                                                  "Maintenance",
                                                              labelText:
                                                                  "Add Subject",
                                                              prefixIcon:
                                                                  Icon(
                                                                Icons.subject,
                                                              ),
                                                            ),
                                                            validator:
                                                                (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Add Subject";
                                                              }
                                                              return null;
                                                            },
                                                            controller:
                                                                add_subject,
                                                          ),
                                                          SizedBox(
                                                              height: 20),
                                                          TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          20)),
                                                              hintText:
                                                                  "Late maintenance",
                                                              labelText:
                                                                  "Add complaints",
                                                              prefixIcon:
                                                                  Icon(
                                                                Icons
                                                                    .info_outline_rounded,
                                                              ),
                                                            ),
                                                            validator:
                                                                (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return "Add complaints";
                                                              }
                                                              return null;
                                                            },
                                                            controller:
                                                                add_complaints,
                                                          ),
                                                          SizedBox(
                                                              height: 20),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Add Complaints",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewMember(),
                                ));
                          },
                          child: Text(
                            "View Members",
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
                          onTap: () {},
                          child: Text(
                            "View Notice",
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
        ),
      ]),
    );
  }
}
