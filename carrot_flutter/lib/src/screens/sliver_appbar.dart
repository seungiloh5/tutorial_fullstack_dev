import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("피드 상세 보기"),
              background: Image(
                image: AssetImage(
                    'assets/images/pikachu_flutter.png'), // 배경 이미지 예시
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.star),
                  title: Text('아이템 $index'),
                );
              },
              childCount: 20, // 리스트 아이템 개수
            ),
          ),
        ],
      ),
    );
  }
}
