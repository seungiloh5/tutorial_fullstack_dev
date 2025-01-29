import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/app.dart';
// import 'src/shared/global.dart';

Future<void> main() async {
  await GetStorage.init();
  final box = GetStorage();

  String? token = box.read('access_token');
  bool isLogin = (token != null) ? true : false; // 토큰이 있으면 로그인 상태

  if (isLogin) {
    print('로그인 상태');
  } else {
    print('로그아웃 상태');
  }

  runApp(MyApp(isLogin));
}
