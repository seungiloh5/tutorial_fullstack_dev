import 'package:flutter/material.dart';
import '../auth/register.dart';
import '../feed/show.dart';
import '../shared/data.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '이 책은 플러터로 \nSNS 중고 거래 애플리케이션을 만듭니다.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 기존 코드
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => FeedShow(feedList[0]),
                //   ),
                // );

                // 바뀐 코드
                Navigator.pushNamed(context, '/feed/2');
              },
              child: const Text('물건 사러 가기'),
            ),
          ],
        ),
      ),
    );
  }
}
