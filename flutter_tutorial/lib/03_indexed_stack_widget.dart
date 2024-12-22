import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: 1,
          children: <Widget>[
            Container(
              color: Colors.blue,
              width: 300,
              height: 300,
            ),
            Container(
              color: Colors.green,
              width: 300,
              height: 300,
            ),
            Container(
              color: Colors.red,
              width: 300,
              height: 300,
            ),
            Container(
              color: Colors.yellow,
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
