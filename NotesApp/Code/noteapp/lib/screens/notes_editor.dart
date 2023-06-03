// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/styles/styles.dart';

class noteEditor extends StatefulWidget {
  const noteEditor({super.key});

  @override
  State<noteEditor> createState() => _noteEditorState();
}

class _noteEditorState extends State<noteEditor> {
  int color_id = Random().nextInt(styleapp.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController _title = TextEditingController();
  TextEditingController _main = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: styleapp.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: styleapp.cardsColor[color_id],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: styleapp.mainTitle,
            ),
            SizedBox(height: 8),
            Text(date, style: styleapp.dateTitle),
            SizedBox(height: 28),
            TextField(
              controller: _main,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Note Content",
              ),
              style: styleapp.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: styleapp.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection("notes").add({
            "notes_title": _title.text,
            "creation_date": date,
            "notes_content": _main.text,
            "color_id": color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
              (error) => print("Failed to add new note due to $error"));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
