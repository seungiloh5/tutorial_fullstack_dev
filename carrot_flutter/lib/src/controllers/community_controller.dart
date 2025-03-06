import 'package:get/get.dart';

import '../models/community_model.dart';
import '../provider/community_provider.dart';

class CommunityController extends GetxController {
  final provider = Get.put(CommunityProvider());
  final RxList<CommunityModel> itemList = <CommunityModel>[].obs;
  final Rx<CommunityModel?> currentItem = Rx<CommunityModel?>(null);

  final List<String> categories = ['맛집', '고민/사연', '동네친구', '운동', '미용', '취미'];

  Future<void> communityIndex({int page = 1}) async {
    Map json = await provider.index(page);
    List<CommunityModel> tmp = json['data']
        .map<CommunityModel>((m) => CommunityModel.parse(m))
        .toList();
    (page == 1) ? itemList.assignAll(tmp) : itemList.addAll(tmp);
  }

  Future<bool> communityCreate(
      String category, String title, String content, int? image) async {
    Map body = await provider.store(category, title, content, image);
    if (body['result'] == 'ok') {
      print("DB에 커뮤니티 피드 생성 완료");
      await communityIndex();
      return true;
    }
    Get.snackbar('생성 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<bool> communityUpdate(
      int id, String category, String title, String content, int? image) async {
    Map body = await provider.update(id, category, title, content, image);
    if (body['result'] == 'ok') {
      int index = itemList.indexWhere((feed) => feed.id == id);
      if (index != -1) {
        CommunityModel updatedFeed = itemList[index].copyWith(
          category: category,
          title: title,
          content: content,
          imageId: image,
        );
        itemList[index] = updatedFeed;
      }
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> communityShow(int id) async {
    Map body = await provider.show(id);
    if (body['result'] == 'ok') {
      print("DB로 부터 커뮤니티 피드 조회 완료");
      print(body['data']);
      currentItem.value = CommunityModel.parse(body['data']);
      return;
    }
    Get.snackbar('피드 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    currentItem.value = null;
  }

  Future<bool> communityDelete(int id) async {
    Map body = await provider.destroy(id);
    print(body);
    if (body['result'] == 'ok') {
      itemList.removeWhere((feed) => feed.id == id);
      return true;
    }
    Get.snackbar('삭제 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
