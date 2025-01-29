import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/file_provider.dart';
import '../shared/global.dart';

class FileController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final provider = Get.put(FileProvider());
  final imageId = Rx<int?>(null);

  String? get imageUrl =>
      imageId.value != null ? "${Global.baseUrl}/file/${imageId.value}" : null;

  Future<void> upload() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      print("[FileController] 이미지 선택 실패");
      return;
    }
    Map body = await provider.imageUpload(image.name, image.path);
    if (body['result'] == 'ok') {
      print("[FileController] 이미지 업로드 성공}");
      imageId.value = body['data'] as int;
    }
  }
}
