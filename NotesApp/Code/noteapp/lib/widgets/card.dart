import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/styles/styles.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: styleapp.cardsColor[doc['color_id']],
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["notes_title"],
            style: styleapp.mainTitle,
          ),
          SizedBox(height: 4),
          Text(
            doc["creation_date"],
            style: styleapp.mainTitle,
          ),
          SizedBox(height: 8),
          Text(
            doc["notes_content"],
            style: styleapp.mainTitle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
