import 'provider.dart';

class FeedProvider extends Provider {
  /// 피드 목록 조회
  Future<Map> index(int page) async {
    final response = await get(
      '/api/feed',
      query: {'page': '$page'},
    );
    if (response.hasError) {
      return {};
    }
    return response.body ?? {};
  }

  // 피드 수정
  Future<Map> update(
      int id, String title, int price, String content, int? image) async {
    final Map<String, dynamic> body = {
      'title': title,
      'price': price,
      'content': content,
    };

    if (image != null) {
      body['imageID'] = image.toString();
    }

    final response = await put('/api/feed/$id', body);
    if (response.hasError) {
      return {};
    }
    return response.body ?? {};
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
    print("[FeedProvider] 서버로부터 받은 답변: ${response.body}");
    if (response.hasError) {
      return {};
    }
    return response.body ?? {};
  }

  Future<Map> show(int id) async {
    final response = await get('/api/feed/$id');
    if (response.hasError) {
      return {};
    }
    return response.body ?? {};
  }

  Future<Map> destroy(int id) async {
    final response = await delete('/api/feed/$id');
    if (response.hasError) {
      return {};
    }
    return response.body ?? {};
  }
}
