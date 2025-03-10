import 'package:get/get.dart';
import 'provider.dart';

class FileProvider extends Provider {
  imageUpload(String name, String path) async {
    final form = FormData({'file': MultipartFile(path, filename: name)});
    print(form);

    Response response = await post('/file/upload', form);
    print(response.body);
    return response.body;
  }
}
