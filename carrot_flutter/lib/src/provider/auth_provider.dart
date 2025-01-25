import 'provider.dart';

class AuthProvider extends Provider {
  // 서버에 해당 번호로 인증 코드 요청
  Future<Map> requestPhoneCode(String phone) async {
    // POST 요청으로 핸드폰 번호 전달
    final response = await post(
      '/auth/phone',
      {'phone': phone}, // Body 데이터
    );
    print('[AuthProvider] 응답 내용: ${response.body}');
    return response.body;
  }

  // 받은  코드를 서버에 전송하여 인증
  Future<Map> verifyPhoneNumber(String code) async {
    final response = await put('/auth/phone', {'code': code});
    return response.body;
  }

  // 전화번호, 비밀번호, 이름을 사용하여 사용자 등록
  Future<Map> register(String phone, String password, String name,
      [int? profile]) async {
    final response = await post('/auth/register', {
      'phone': phone,
      'password': password,
      'name': name,
      'profile': profile,
    });

    return response.body;
  }

  // 등록된 사용자 정보로 로그인 시도
  Future<Map> login(String phone, String password) async {
    final response = await post('/auth/login', {
      'phone': phone,
      'password': password,
    });
    return response.body;
  }
}
