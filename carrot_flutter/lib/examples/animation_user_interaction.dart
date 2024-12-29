import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: UserInteraction(),
  ));
}

class UserInteraction extends StatefulWidget {
  const UserInteraction({Key? key}) : super(key: key);

  @override
  State<UserInteraction> createState() => _UserInteractionState();
}

class _UserInteractionState extends State<UserInteraction> {
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
          child: const Text('클릭하세요'),
        ),
      ),
    );
  }
}
