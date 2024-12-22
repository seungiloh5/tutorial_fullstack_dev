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
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.blue,
                width: 300,
                height: 300,
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
                top: 0,
                left: 0,
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                bottom: 0,
                left: 0,
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.yellow,
                ),
                top: 0,
                right: 0,
              ),
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.orange,
                ),
                bottom: 0,
                right: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
