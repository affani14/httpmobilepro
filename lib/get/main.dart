import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late String id;
  late String email;
  late String name;

  @override
  void initState() {
    id = "";
    email = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Http Get"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ID : $id",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "EMAIL : $email",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "NAME : $name",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                var myresponse = await http.get(
                  Uri.parse('https://reqres.in/api/users/1'),
                );

                if (myresponse.statusCode == 200) {
                  print("BERHASIL GET DATA");
                  Map<String, dynamic> data = json.decode(myresponse.body)['data'] as Map<String, dynamic>;

                  setState(() {
                    id = data['id'].toString();
                    email = data['email'];
                    name = data['first_name'] + " " + data['last_name'];
                  });
                } else {
                  print("ERROR ${myresponse.statusCode}");
                }
              },
              child: const Text("Get DATA"),
            ),
          ],
        ),
      ),
    );
  }
}
