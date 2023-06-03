// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MemberModel {
  String? name;
  String? contact;
  String? house;
  MemberModel({
    this.name,
    this.contact,
    this.house,
  });

  factory MemberModel.fromJson(Map<String, dynamic> map) {
    return MemberModel(
      name: map['name'],
      contact: map['contact'],
      house: map['house'],
    );
  }
}

class ViewMember extends StatefulWidget {
  const ViewMember({super.key});

  @override
  State<ViewMember> createState() => _ViewMemberState();
}

class _ViewMemberState extends State<ViewMember> {
  String url =
      "https://mishriflutter.000webhostapp.com/DigitalSociety/fetchallmember.php";

  Future<List<MemberModel>> fetchmember() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => MemberModel.fromJson(e)).toList();
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
          title: const Text("Society Members"),
        ),
        body: FutureBuilder(
          future: fetchmember(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MemberModel> memberdata = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          child: ListTile(
            title: Text(memberdata[index].name!,style: const TextStyle(
              fontSize: 20
            ),),
            subtitle: Text(memberdata[index].contact!),
            trailing: Text("House No : ${memberdata[index].house!}"),
            
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
