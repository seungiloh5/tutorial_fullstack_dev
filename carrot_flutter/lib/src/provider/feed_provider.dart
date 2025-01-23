import 'package:get/get.dart';
import 'provider.dart';

class FeedProvider extends Provider {
  /// 피드 목록 조회
  Future<Map> index(int page) async {
    final response = await get(
      '/api/feed',
      query: {'page': '$page'},
    );
    return response.body;
  }

  /// 피드 생성
  Future<Map> store(
      String title, String price, String content, int? image) async {
    final Map<String, dynamic> body = {
      'title': title,
      'price': price,
      'content': content,
    };

    if (image != null) {
      body['image'] = image;
    }

    final response = await post('/api/feed', body);
    return response.body;
  }
}
