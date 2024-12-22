import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stateful Widget 변화 과정'),
        ),
        body: Center(
          child: TextInputWidget(),
        ),
      ),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  String _text = '';

  void _handleTextChanged(String newText) {
    setState(() {
      _text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          onChanged: _handleTextChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '여기에 텍스트를 입력하세요',
          ),
        ),
        SizedBox(height: 20),
        Text(
          '입력한 텍스트: $_text',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
