import 'package:get/get.dart';
import '../provider/user_provider.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final userProvider = Get.put(UserProvider());
  final Rx<UserModel?> my = Rx<UserModel?>(null);

  Future<void> myInfo() async {
    Map body = await userProvider.show();
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return;
    }
    Get.snackbar('회원 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
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
