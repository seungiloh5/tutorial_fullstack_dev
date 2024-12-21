// 비동기적으로 사용자 데이터를 가져오는 함수
Future<String> fetchUserData() {
  // 가상의 사용자 데이터를 2초 후에 반환합니다.
  return Future.delayed(Duration(seconds: 2), () => 'User Data');
}

// 비동기 함수를 호출하는 메인 함수
void main() async {
  // fetchUserData()의 완료를 기다립니다.
  print(0);
  String data = await fetchUserData(); // 값을 받아오는데 2초 걸림
  print(1);
  print(data);
  print(2);
}
