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
        body: SafeArea(
          // child: Container(
          //   color: Colors.yellow,
          //   child: const Row(
          //     mainAxisSize: MainAxisSize.max,
          //     // mainAxisSize: MainAxisSize.min,
          //     // mainAxisAlignment: MainAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     // mainAxisAlignment: MainAxisAlignment.end,
          //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Text('Hello'),
          //       Text('World!'),
          //     ],
          //   ),
          // ),
          child: Container(
            height: 100,
            color: Colors.yellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(color: Colors.red, width: 50, height: 80),
                Container(color: Colors.green, width: 50, height: 30),
                Container(color: Colors.blue, width: 50, height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
