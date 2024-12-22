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
            child: Column(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 30.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Elevated Button'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Text Button'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Outlined Button'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
