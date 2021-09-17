import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome User"),
                SizedBox(
                  height: 50,
                ),
                OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.exit_to_app, size: 18),
                    label: Text("Logout")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
