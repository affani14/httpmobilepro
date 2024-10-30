import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import './models/user.dart';

void  main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  List<Data> allUser = [];

  Future getAllUser() async {
    try {
      var response = await http.get(Uri.parse("https://reqres.in/api/users?page=3"));
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      data.forEach((element) {
        allUser.add(UserModel.fromJson(element) as Data);
      });

      print(allUser);
    } catch (e) {
      print("Terjadi Kesalahan");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Builder"),
      ),
      body: FutureBuilder(
        future: getAllUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading .."),
            );
          } else {
            return ListView.builder(
              itemCount: allUser.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(allUser[index].avatar),
                ),
                title: Text("${allUser[index].firstName} ${allUser[index].lastName}"),
                subtitle: Text("${allUser[index].email}"),
              ),
            );
          }
        },
      ),
    );
  }
}