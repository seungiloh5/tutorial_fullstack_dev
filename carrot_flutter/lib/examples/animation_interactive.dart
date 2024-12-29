import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TestApp(),
  ));
}

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.red.shade200; // 버튼이 눌렸을 때 색상
                }
                return Colors.blue; // 기본 색상
              },
            ),
          ),
          child: AnimatedScale(
            scale: isPressed ? 0.95 : 1.0,
            duration: Duration(milliseconds: 200),
            child: Text('버튼'),
          ),
        ),
      ),
    );
  }
}
