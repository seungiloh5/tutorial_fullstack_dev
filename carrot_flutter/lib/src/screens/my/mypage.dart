import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/listitems/user_mypage.dart';
import '../../models/user_model.dart';
import '../../screens/feed/my.dart';
import '../../screens/my/webpage.dart';
import '../../screens/auth/intro.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final authController = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필
            Obx(
              () {
                if (userController.my.value == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return UserMyPage(userController.my.value!);
                }
              },
            ),
            // 기타 메뉴
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '나의 거래',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            ListTile(
              title: Text('판매내역'),
              leading: Icon(Icons.receipt_long_outlined),
              onTap: () {
                Get.to(() => const FeedMy());
              },
            ),
            ListTile(
              title: Text('로그아웃'),
              leading: Icon(Icons.logout_outlined),
              onTap: () async {
                await authController.logout();
                Get.offAll(() => const Intro());
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('이용약관'),
              onTap: () {
                Get.to(() => const WebPage('이용약관', '/page/terms'));
              },
            ),
            ListTile(
              title: const Text('개인정보 처리방침'),
              onTap: () {
                Get.to(() => const WebPage('개인정보 처리방침', '/page/policy'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
