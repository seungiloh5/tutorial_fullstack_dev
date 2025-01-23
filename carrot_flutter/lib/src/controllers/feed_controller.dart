import 'dart:math';
import 'package:get/get.dart';
import '../provider/feed_provider.dart';
import '../models/feed_model.dart';

class FeedController extends GetxController {
  final feedProvider = Get.put(FeedProvider());
  RxList<FeedModel> feedList = <FeedModel>[].obs;

  feedIndex({int page = 1}) async {
    Map json = await feedProvider.index(page);
    List<FeedModel> tmp =
        json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? feedList.assignAll(tmp) : feedList.addAll(tmp);
  }

  Future<bool> feedCreate(
      String title, String price, String content, int? image) async {
    Map body = await feedProvider.store(title, price, content, image);
    if (body['result'] == 'ok') {
      await feedIndex(); // 생성 후 목록 갱신
      return true;
    }
    Get.snackbar('생성 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  void addData() {
    final random = Random();
    final newItem = FeedModel.parse({
      'id': random.nextInt(100),
      'title': '제목: ${random.nextInt(100)}', // 0~99 사이의 번호
      'description': '설명 ${random.nextInt(100)}',
      'price': 500 + random.nextInt(49500), // 500원에서 50000원 사이
    });
    feedList.add(newItem);
  }

  void updateData(FeedModel updatedItem) {
    final index = feedList.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      feedList[index] = updatedItem;
    }
  }
}
