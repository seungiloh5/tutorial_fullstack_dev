import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';
import '../../widgets/buttons/category_button.dart';
import '../../widgets/listitems/feed_list_item.dart';

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});

  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  final FeedController feedController = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: feedController.addData,
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
            child: Obx(
              () => ListView.builder(
                itemCount: feedController.feedList.length,
                itemBuilder: (context, index) {
                  final item = feedController.feedList[index];
                  return FeedListItem(item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
