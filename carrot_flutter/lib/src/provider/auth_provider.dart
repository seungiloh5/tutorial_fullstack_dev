import 'provider.dart';

class AuthProvider extends Provider {
  // 서버에 해당 번호로 인증 코드 요청
  Future<Map> requestPhoneCode(String phone) async {
    final response = await post('/api/phone', {phone});

    // 서버가 등록되지 않아 임시로 작성 (동작 테스트 후 삭제)
    if (response.body == null) {
      return {
        'result': 'ok',
        "expired": "2025-01-31T12:34:56.000",
      };
    }
    return response.body;
  }

  // 받은  코드를 서버에 전송하여 인증
  Future<Map> verifyPhoneNumber(String code) async {
    final response = await put('/api/phone', {'code'});

    // 서버가 등록되지 않아 임시로 작성 (동작 테스트 후 삭제)
    if (response.body == null) {
      return {
        'result': 'ok',
        "message": "서버 미등록으로 인한 임시 테스트",
      };
    }
    return response.body;
  }

  // 전화번호, 비밀번호, 이름을 사용하여 사용자 등록
  Future<Map> register(String phone, String password, String name,
      [int? profile]) async {
    final response = await post('/api/register', {
      'phone': phone,
      'password': password,
      'name': name,
      'profile': profile,
    });

    // 서버가 등록되지 않아 임시로 작성 (동작 테스트 후 삭제)
    if (response.body == null) {
      return {
        'result': 'ok',
        "message": "서버 미등록으로 인한 임시 테스트",
      };
    }
    return response.body;
  }

  // 등록된 사용자 정보로 로그인 시도
  Future<Map> login(String phone, String password) async {
    final response = await post('/api/login', {
      'phone': phone,
      'password': password,
    });

    // 서버가 등록되지 않아 임시로 작성 (동작 테스트 후 삭제)
    if (response.body == null) {
      return {
        'result': 'ok',
        "message": "서버 미등록으로 인한 임시 테스트",
      };
    }
    return response.body;
  }
}
