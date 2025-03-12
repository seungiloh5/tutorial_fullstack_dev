import 'package:get/get.dart';
import '../provider/user_provider.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final userProvider = Get.put(UserProvider());
  final Rx<UserModel?> my = Rx<UserModel?>(null);

  Future<void> myInfo() async {
    Map body = await userProvider.show();
    final data = body['data'] ?? {};

    if (body['result'] == 'ok') {
      my.value = UserModel.parse(data);
      return;
    }

    Get.snackbar('회원 에러', body['message'] ?? '알 수 없는 오류가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<bool> updateInfo(String name, int? image) async {
    Map body = await userProvider.update(name, image);
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return true;
    }
    Get.snackbar('회원 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
