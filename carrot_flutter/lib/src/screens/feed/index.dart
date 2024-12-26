import 'dart:math';
import 'package:flutter/material.dart';

import '../../widgets/buttons/category_button.dart';
import '../../widgets/listitems/feed_list_item.dart';

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});

  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  List<Map<String, dynamic>> feedList = [
    {
      'id': 1,
      'title': '텀블러',
      'content': '텀블러 팝니다',
      'price': 500,
    },
    {
      'id': 2,
      'title': '머그잔',
      'content': '머그잔 텀브러랑 교환도 합니다.',
      'price': 300,
    },
  ];

  addItem() {
    final random = Random();
    final newItem = {
      'id': random.nextInt(1000),
      'title': '제목: ${random.nextInt(100)}', // 0~99 사이의 번호
      'description': '설명 ${random.nextInt(100)}',
      'price': random.nextInt(49500), // 500원에서 50000원 사이
    };
    setState(() {
      feedList.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('동네생활'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          // CategoryBar
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CategoryButton(icon: Icons.menu),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.search, title: '알바'),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.home, title: '부동산'),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.car_crash, title: '중고차'),
              ],
            ),
          ),
          // ListContent
          Expanded(
            child: ListView.builder(
              itemCount: feedList.length,
              itemBuilder: (context, index) {
                final item = feedList[index];
                return FeedListItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
