import 'package:get/get.dart';
import '../shared/global.dart';

class Provider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Global.baseUrl;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      if (request.url.toString().contains('/api/')) {
        request.headers['Authorization'] = 'Bearer ${Global.accessToken}';
      }
      return request;
    });
  }
}
