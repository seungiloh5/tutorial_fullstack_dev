import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController 선언
    final controller = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller, // 컨트롤러 설정
                  decoration: InputDecoration(
                    labelText: '이름',
                    hintText: '이름을 입력하세요',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person),
                  ),
                  onChanged: (text) {
                    print("현재 입력값: $text");
                  },
                  onSubmitted: (text) {
                    print("완료된 입력값: $text");
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // 컨트롤러를 통해 텍스트 값 얻기
                    final text = controller.text;
                    print("컨트롤러로 얻은 입력값: $text");
                  },
                  child: const Text('텍스트 출력하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
