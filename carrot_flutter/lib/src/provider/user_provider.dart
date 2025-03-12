import 'provider.dart';

class UserProvider extends Provider {
  Future<Map> show() async {
    final response = await get('/api/user/my');

    if (response.body == null) {
      print("[UserProvider] Response body is null");
      return {};
    }

    return response.body;
  }

  Future<Map> update(String name, int? image) async {
    final Map<String, dynamic> body = {
      'name': name,
    };

    if (image != null) {
      body['profile_id'] = image.toString();
    }

    final response = await put('/api/user/my', body);

    if (response.body == null) {
      print("[UserProvider] Response body is null");
      return {};
    }

    return response.body;
  }
}
