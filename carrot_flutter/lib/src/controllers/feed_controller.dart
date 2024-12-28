import 'dart:math';
import 'package:get/get.dart';

class FeedController extends GetxController {
  RxList<Map> feedList = <Map>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initialData();
  }

  _initialData() {
    List<Map> sample = [
      {
        'id': 1,
        'title': '텀블러',
        'content': '팝니다',
        'price': 500,
      },
      {
        'id': 2,
        'title': '머그잔',
        'content': '교환가능',
        'price': 300,
      },
    ];
    feedList.assignAll(sample);
  }

  void addData() {
    final random = Random();
    final newItem = {
      'id': random.nextInt(100),
      'title': '제목: ${random.nextInt(100)}', // 0~99 사이의 번호
      'description': '설명 ${random.nextInt(100)}',
      'price': 500 + random.nextInt(49500), // 500원에서 50000원 사이
    };
    feedList.add(newItem);
  }

  void updateData(Map newData) {
    final id = newData['id'];
    final index = feedList.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      feedList[index] = newData;
    }
  }
}
