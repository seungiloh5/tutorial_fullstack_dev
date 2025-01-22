import 'package:get/get.dart';
import 'provider.dart';

class FeedProvider extends Provider {
  // 피드 리스트 (매물 목록)
  Future<Map> getList({int page = 1}) async {
    Response response = await get(
      '/api/feed',
      query: {'page': '$page'},
    );
    print(response.statusCode);
    print(response.bodyString);
    return response.body;
  }

  Future<Map> index({int page = 1}) async {
    final response = await get(
      '/api/feed',
      query: {'page': '$page'},
    );
    return response.body;
  }
}
