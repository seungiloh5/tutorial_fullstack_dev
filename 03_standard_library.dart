import 'dart:convert'; // JSON 데이터를 처리하기 위한 라이브러리
import 'dart:io'; // 파일 I/O를 위한 라이브러리

// 메인 함수는 비동기적으로 실행됩니다.
void main() async {
  final file = File('example.json');

  // 파일의 내용을 문자열로 읽어옵니다.
  String contents = await file.readAsString();

  // 읽어올 문자열을 JSON으로 파싱합니다.
  Map<String, dynamic> data = jsonDecode(contents);

  print('Name: ${data['name']}, Age: ${data['age']}');
}
