import 'dart:math';
import 'package:get/get.dart';
import '../provider/feed_provider.dart';
import '../models/feed_model.dart';

class FeedController extends GetxController {
  final feedProvider = Get.put(FeedProvider());
  final RxList<FeedModel> feedList = <FeedModel>[].obs;
  final RxList<FeedModel> searchList = <FeedModel>[].obs;
  final RxList<FeedModel> myFeedList = <FeedModel>[].obs;
  final Rx<FeedModel?> currentFeed = Rx<FeedModel?>(null);

  feedIndex({int page = 1}) async {
    Map json = await feedProvider.index(page);
    // p.459라 약간 다름
    List<FeedModel> tmp =
        (json['data'] ?? []).map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? feedList.assignAll(tmp) : feedList.addAll(tmp);
  }

  searchIndex(String keyword, {int page = 1}) async {
    Map json = await feedProvider.index(page, keyword: keyword);
    List<FeedModel> tmp =
        (json['data'] ?? []).map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? searchList.assignAll(tmp) : searchList.addAll(tmp);
  }

  myIndex({int page = 1}) async {
    Map json = await feedProvider.myIndex(page);
    List<FeedModel> tmp =
        json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? myFeedList.assignAll(tmp) : myFeedList.addAll(tmp);
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

  feedUpdate(int id, String title, String priceString, String content,
      int? image) async {
    int price = int.tryParse(priceString) ?? 0; // int로 변환, 실패 시 0

    Map body = await feedProvider.update(id, title, price, content, image);

    if (body['result'] == 'ok') {
      int index = feedList.indexWhere((feed) => feed.id == id);
      if (index != -1) {
        FeedModel updatedFeed = feedList[index].copyWith(
          title: title,
          price: price,
          content: content,
          imageId: image,
        );
        feedList[index] = updatedFeed;
      }
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
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

  Future<void> feedShow(int id) async {
    Map body = await feedProvider.show(id);
    if (body['result'] == 'ok') {
      currentFeed.value = FeedModel.parse(body['data']);
    } else {
      Get.snackbar('피드 에러', body['message'],
          snackPosition: SnackPosition.BOTTOM);
      currentFeed.value = null;
    }
  }

  Future<bool> feedDelete(int id) async {
    Map body = await feedProvider.destroy(id);
    if (body['result'] == 'ok') {
      feedList.removeWhere((feed) => feed.id == id);
      return true;
    }
    Get.snackbar('삭제 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
