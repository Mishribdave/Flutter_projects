import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPost {
  String? name;
  String? subject;
  String? city;

  MyPost({this.name, this.subject, this.city});

  factory MyPost.fromJson(Map<String, dynamic> myjson) {
    return MyPost(
      name: myjson['name'],
      subject: myjson['subject'],
      city: myjson['city'],
    );
  }
}

Future<bool> fetchData(String name) async {
  var response = await http.get(
      Uri.parse("https://sanjanaprac.000webhostapp.com/login.php?name=$name"));
  var data = json.decode(response.body);

  if (response.statusCode == 200 && data.isNotEmpty) {
    // Login successful
    return true;
  } else {
    // Login failed
    return false;
  }
}

class MyLoginApi extends StatefulWidget {
  const MyLoginApi({Key? key}) : super(key: key);

  @override
  State<MyLoginApi> createState() => _MyLoginApiState();
}

class _MyLoginApiState extends State<MyLoginApi> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Enter name",
              labelText: "Enter name",
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              bool loginStatus =
                  await fetchData(_nameController.text.toString());
              if (loginStatus) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Login Successful'),
                      content: Text('You have successfully logged in.'),
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
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}
