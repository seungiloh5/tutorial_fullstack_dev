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
          child: Center(
            child: Container(
              height: 60,
              width: 100,
              color: Colors.yellow,
              child: Image.asset(
                'assets/images/pikachu_flutter.png',
                // fit: BoxFit.fill,
                fit: BoxFit.contain,
                // fit: BoxFit.cover,
                // fit: BoxFit.fitWidth,
                // fit: BoxFit.fitHeight,
                // fit: BoxFit.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
