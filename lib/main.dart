import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test14/second.dart';

void main() {
  runApp(MyApp());
}

/*class URLS {
  static const String BASE_URL = 'http://test11.internative.net/Login/SignIn';
  //static const String email = 'email';
  //static const String password = 'password';
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '<Your token>'
  };
}*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.email)),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.password)),
                ),
                SizedBox(
                  height: 45,
                ),
                OutlinedButton.icon(
                    onPressed: () {
                      login(emailController, passController, context);
                    },
                    icon: Icon(Icons.login),
                    label: Text("Login")),
              ],
            ),
          ))),
    );
  }

  Future<dynamic> login(TextEditingController email,
      TextEditingController password, BuildContext context) async {
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse("http://test11.internative.net/Login/SignIn"),
        body: jsonEncode({
          "email": emailController.text,
          "password": passController.text,
          // "HasError": true,
        }),
        headers: {
          // $["HasError"] = "false",
          "content-type": "application/json",
          HttpHeaders.authorizationHeader:
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiI2MTI3NTRkZDRhMWMyZDM0NmNmZDk0NmQiLCJmdWxsTmFtZSI6IkVyZW4gS2F5YSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlVzZXIiLCJuYmYiOjE2MzE4MDMwOTUsImV4cCI6MTYzNDM5NTA5NSwiaXNzIjoiaSIsImF1ZCI6ImEifQ.q9WR6DX9DHzd_1yUVBS3dFmpTJsWOWSzjNTjCxe9LCY',
          //'Authorization':
          //  '<Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiI2MTI3NTRkZDRhMWMyZDM0NmNmZDk0NmQiLCJmdWxsTmFtZSI6IkVyZW4gS2F5YSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlVzZXIiLCJuYmYiOjE2MzE4MDMwOTUsImV4cCI6MTYzNDM5NTA5NSwiaXNzIjoiaSIsImF1ZCI6ImEifQ.q9WR6DX9DHzd_1yUVBS3dFmpTJsWOWSzjNTjCxe9LCY>',
        },
        //encoding: Encoding.getByName('utf-8')
      );
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Second()));
        print('Request failed with status: ${response.statusCode}.');
        print('Request failed with status: ${response.headers}.');
        print('Request failed with status: ${response.body}.');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("Data:", json.decode(response.body)!["Token"]);

        // return jsonDecode(response.body);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials.")));
        print('Request failed with status: ${response.statusCode}.');
        print('Request failed with status: ${response.headers}.');
        print('Request failed with status: ${response.body}.');
        //throw Exception('Failed to load data!');
        // return jsonDecode(response.body);
      }
    }
    /*Future<void> login() async {
    // print('Name: ${emailController}, Password: ${passController}');
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      /*Map<String, dynamic> loginToJson(json) => <String, dynamic>{
            'email': json.email,
            'password': json.password,
            'hasError': json.hasError,
            'message': json.message,
            'token': json.token
          };*/
      var response = await http.post(
        Uri.parse("http://test11.internative.net/Login/SignIn"),
        body: jsonEncode({
          "email": emailController.text,
          "password": passController.text,
        }),
          headers: {
            "email": emailController.text,
            "password": passController.text,
            "content-type": "application/json",
            'Authorization': '<Your token>'}
      );
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Second()));
        print('Request failed with status: ${response.statusCode}.');
        print('Request failed with status: ${response.headers}.');
        print('Request failed with status: ${response.body}.');
        print('Request failed with status: ${HasError}.');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials.")));
        print('Request failed with status: ${response.statusCode}.');
        print('Request failed with status: ${response.body}.');
        // print('Request failed with status: ${response.HasError}.');

      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Back Field not allowed")));
    }
  }*/
  }

//unction that converts a response body into a List<Photo>.

/*
//service request
Future<void> login() async {
  // print('Name: ${emailController}, Password: ${passController}');
  if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
    var response = await http
        .post(Uri.parse("http://test11.internative.net/Login/SignIn"),
        body: jsonEncode({
          "email": emailController.text,
          "password": passController.text
          // print()
        }),
        headers: {"accept": "", "content-type": "application/json"});
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Second()));
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${response.body}.');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Credentials.")));
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${response.body}.');
    }
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Back Field not allowed")));
  }
}*/
}
