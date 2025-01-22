import 'package:get/get.dart';
import 'provider.dart';

class FeedProvider extends Provider {
  /// 피드 목록 조회
  Future<Map> index({int page = 1}) async {
    try {
      final response = await get(
        '/api/feed',
        query: {'page': '$page'},
      );

      if (response.statusCode == 200) {
        return response.body ?? {}; // 성공 시 본문 반환
      } else {
        throw Exception('요청 실패: 상태 코드 ${response.statusCode}');
      }
    } catch (e) {
      // 에러 처리
      print('index 에러: $e');
      return {'error': 'Failed to fetch data: $e'};
    }
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

    try {
      final response = await post('/api/feed', body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body ?? {}; // 성공 시 본문 반환
      } else {
        throw Exception('요청 실패: 상태 코드 ${response.statusCode}');
      }
    } catch (e) {
      // 에러 처리
      print('store 에러: $e');
      return {'error': 'Failed to create feed: $e'};
    }
  }
}
