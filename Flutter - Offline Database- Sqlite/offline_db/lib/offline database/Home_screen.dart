import 'package:flutter/material.dart';
import 'package:sqflite_assignment/offline%20database/userService.dart';
import 'package:sqflite_assignment/offline%20database/usermodel.dart';
import 'dart:math';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();
  TextEditingController _editnameController = new TextEditingController();
  TextEditingController _editcontactController = new TextEditingController();
  List<UserModel> usersList = [];
  var userservice = UserService();
  var usermodel = UserModel();

  @override
  void initState() {
    getdatafromtable();
    super.initState();
  }

  getdatafromtable() async {
    usersList.clear();
    print("---> inside get method");
    var read = await userservice.readuser();
    read.forEach((row) {
      setState(() {
        var usermodel = UserModel();
        usermodel.id = row["id"];
        usermodel.name = row["name"];
        usermodel.contact = row["contact"];

        usersList.add(usermodel);
        print("----->  this is all data $read");
      });
    });
  }

  deletedatausingdialog(BuildContext context, userid) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete User"),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  var result = await userservice.deleteuser(userid);
                  if (result != null) {
                    getdatafromtable();
                  }
                  Navigator.pop(context);
                },
                child: Text("Yes")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"))
          ],
        );
      },
    );
  }

  updatedatausingdialog(BuildContext context, userid, name, contact) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit User"),
          content: Container(
            height: 150,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: _editnameController,
                  decoration: InputDecoration(
                      hintText: name, border: OutlineInputBorder()),
                ),
                TextField(
                  controller: _editcontactController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: contact),
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  var usermodel = UserModel();
                  usermodel.id = userid;
                  usermodel.name = _editnameController.text;
                  usermodel.contact = _editcontactController.text;

                  var update = await userservice.updateuser(usermodel);
                  getdatafromtable();
                  print(update);
                  Navigator.pop(context);
                },
                child: Text("Update")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Database"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50))),
                            height: 530,
                            child: Column(
                              children: [
                                Text("Enter Your Details",
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      hintText: "Enter Your Name"),
                                ),
                                TextField(
                                  controller: _contactController,
                                  decoration: InputDecoration(
                                      hintText: "Enter Your Contact"),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () async {
                                      usermodel.name = _nameController.text;
                                      usermodel.contact =
                                          _contactController.text;
                                      var save =
                                          await userservice.saveuser(usermodel);
                                      print(save);
                                      setState(() {
                                        var msg = "successfully data submitted";
                                        getdatafromtable();
                                        Navigator.pop(context);
                                      });
                                      _nameController.text = "";
                                      _contactController.text = "";
                                    },
                                    child: Text("Create User"))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text("Add User")),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 80,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              usersList[index].name.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              usersList[index].contact.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        updatedatausingdialog(
                                            context,
                                            usersList[index].id,
                                            usersList[index].name,
                                            usersList[index].contact);
                                      },
                                      child: Icon(Icons.edit)),
                                  SizedBox(width: 15),
                                  InkWell(
                                      onTap: () {
                                        deletedatausingdialog(
                                            context, usersList[index].id);
                                      },
                                      child: Icon(Icons.delete))
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
