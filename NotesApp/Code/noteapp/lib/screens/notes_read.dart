import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/screens/home_screen.dart';
import 'package:noteapp/styles/styles.dart';

// ignore: must_be_immutable
class NotesRead extends StatefulWidget {
  NotesRead(this.doc, {Key? key}) : super(key: key);

  QueryDocumentSnapshot doc;

  @override
  State<NotesRead> createState() => _NotesReadState();
}

final db = FirebaseFirestore.instance;
void update(String docid, String title, String content) {
  db
      .collection("notes")
      .doc(docid)
      .update({"notes_content": "$content", "notes_title": "$title"}).then(
          (value) => log("updated"),
          onError: (e) => log("error"));
}

void delete(String docid) {
  db
      .collection("notes")
      .doc(docid)
      .delete()
      .then((value) => log("deleted successfully"), onError: (e) => "Error");
}

class _NotesReadState extends State<NotesRead> {
  @override
  void initState() {
    print(widget.doc.id);
    edit_title.text = widget.doc["notes_title"];
    edit_content.text = widget.doc["notes_content"];
    super.initState();
  }

  TextEditingController edit_title = TextEditingController();
  TextEditingController edit_content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: styleapp.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: styleapp.cardsColor[color_id],
        elevation: 0,
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                              height: 700,
                              width: 300,
                              child: Column(
                                children: [
                                  SizedBox(height: 15),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: 150,
                                      width: 350,
                                      child: Image.network(
                                        "https://img.etimg.com/thumb/msid-93229764,width-300,height-225,imgsize-510277,,resizemode-75/complaint.jpg",
                                      )),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text("Edit your note",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GoogleFonts.dmSans()
                                                  .fontFamily)),
                                      SizedBox(width: 150),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            update(
                                                widget.doc.id,
                                                edit_title.text.toString(),
                                                edit_content.text.toString());
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GoogleFonts.dmSans()
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
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  hintText: "abc",
                                                  labelText: "Edit title",
                                                  prefixIcon: Icon(
                                                    Icons.subject,
                                                  ),
                                                ),
                                                // validator: (value) {
                                                //   if (value!
                                                //       .isEmpty) {
                                                //     return "Add Subject";
                                                //   }
                                                //   return null;
                                                // },
                                                controller: edit_title),
                                            SizedBox(height: 20),
                                            TextFormField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  hintText: "abcdef",
                                                  labelText: "Edit content",
                                                  prefixIcon: Icon(
                                                    Icons.info_outline_rounded,
                                                  ),
                                                ),
                                                // validator: (value) {
                                                //   if (value!
                                                //       .isEmpty) {
                                                //     return "Add complaints";
                                                //   }
                                                //   return null;
                                                // },
                                                controller: edit_content),
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
                  child: Text("Edit",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontFamily: GoogleFonts.dmSans().fontFamily,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  print("dialog");
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Are you sure you want to delete data"),
                        actions: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "No",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                delete(widget.doc.id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => homescreen(),
                                    ));
                              });
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.delete,
                  size: 25,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Container(
                  height: 100,
                  width: 350,
                  child: AlertDialog(
                    title: Text("Are you Sure you want to delete this notes"),
                    actions: [Text("Yes"), Text("No")],
                  ),
                );
              },
            );
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doc["notes_title"],
                  style: styleapp.mainTitle,
                ),
                SizedBox(height: 4),
                Text(
                  widget.doc["creation_date"],
                  style: styleapp.mainTitle,
                ),
                SizedBox(height: 28),
                Text(
                  widget.doc["notes_content"],
                  style: styleapp.mainTitle,
                  // overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
