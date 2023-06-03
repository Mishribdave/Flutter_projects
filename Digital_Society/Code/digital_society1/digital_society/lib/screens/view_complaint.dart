// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Complaint_model {
  String? complaint_subject;
  String? complaint_desc;
  String? issuedby;
  String? contact;
  String? house;
  Complaint_model({
    this.complaint_subject,
    this.complaint_desc,
    this.issuedby,
    this.contact,
    this.house,
  });

  factory Complaint_model.fromJson(Map<String, dynamic> map) {
    return Complaint_model(
      complaint_subject: map['complaint_subject'],
      complaint_desc: map['complaint_desc'],
      issuedby: map['issuedby'],
      contact: map['contact'],
      house: map['house'],
    );
  }
}

class View_complaints extends StatefulWidget {
  const View_complaints({super.key});

  @override
  State<View_complaints> createState() => _View_complaintsState();
}

class _View_complaintsState extends State<View_complaints> {
  String url =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/fetch_complaint.php";

  Future<List<Complaint_model>> fetchComplaint() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Complaint_model.fromJson(e)).toList();
    } else {
      throw Exception("invalid data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 222, 202, 225),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Member Complaints"),
        ),
        body: FutureBuilder(
          future: fetchComplaint(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Complaint_model> complaint_data = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(
                            complaint_data[index].complaint_subject!,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            complaint_data[index].complaint_desc!,
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.w700),
                          ),

                          trailing: Text(
                            " ${complaint_data[index].contact!}",
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.w500),
                          ),
                          // isThreeLine: true,
                          // leading: Text(
                          //   complaint_data[index].house!,
                          //   style: TextStyle(
                          //       fontSize: 18,
                          //       fontFamily: GoogleFonts.dmSans().fontFamily,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
