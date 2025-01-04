import 'provider.dart';

class AuthProvider extends Provider {
  Future<Map> requestPhoneCode(String phone) async {
    final response = await post('/auth/phone', {'phone': phone});

    // 서버가 등록되지 않아 임시로 작성
    if (response.body == null) {
      return {
        'result': 'ok',
        "expired": "2025-01-31T12:34:56.000",
      };
    }
    return response.body;
  }

  Future<Map> verifyPhoneNumber(String code) async {
    final response = await put('/auth/phone', {'code': code});

    // 서버가 등록되지 않아 임시로 작성
    if (response.body == null) {
      return {
        'result': 'ok',
        "message": "인증번호를 다시 확인해주세요.",
      };
    }
    return response.body;
  }

  Future<Map> register(String phone, String password, String name,
      [int? profile]) async {
    final response = await post('/auth/register', {
      'phone': phone,
      'password': password,
      'name': name,
      'profile': profile,
    });

    // 서버가 등록되지 않아 임시로 작성
    if (response.body == null) {
      return {
        'result': 'ok',
        "message": "회원가입이 완료되었습니다.",
      };
    }
    return response.body;
  }
}
