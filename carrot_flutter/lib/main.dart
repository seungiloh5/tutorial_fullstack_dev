import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:get/get.dart';
import 'src/shared/global.dart';

void main() {
  String token = Global.accessToken;
  bool isLogin = token.isNotEmpty; // 토큰이 있으면 로그인 상태

  runApp(MyApp(isLogin));
}
