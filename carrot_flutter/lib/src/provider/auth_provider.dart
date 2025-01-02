import 'provider.dart';

class AuthProvider extends Provider {
  Future<Map> requestPhoneCode(String phone) async {
    final response = await post('/auth/phone', {'phone': phone});
    return response.body;
  }

  Future<Map> verifyPhoneNumber(String code) async {
    final response = await put('/auth/phone', {'code': code});
    return response.body;
  }
}
