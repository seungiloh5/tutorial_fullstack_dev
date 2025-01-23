import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';
import '../../widgets/buttons/category_button.dart';
import '../../widgets/listitems/feed_list_item.dart';
import 'create.dart';

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});

  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  final FeedController feedController = Get.put(FeedController());
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    feedController.feedIndex(page: _currentPage);
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.feedIndex(page: _currentPage);
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.feedIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // onPressed: feedController.addData,
        onPressed: () {
          Get.to(() => const FeedCreate());
        },
        tooltip: '항목추가',
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
          // 카테고리 바
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryButton(onTap: () {}, icon: Icons.menu),
                SizedBox(width: 12),
                CategoryButton(onTap: () {}, icon: Icons.search, title: '알바'),
                SizedBox(width: 12),
                CategoryButton(onTap: () {}, icon: Icons.home, title: '부동산'),
                SizedBox(width: 12),
                CategoryButton(
                    onTap: () {}, icon: Icons.car_crash, title: '중고차'),
              ],
            ),
          ),
          // 중고 거래 목록
          Expanded(
            child: Obx(
              () {
                return NotificationListener<ScrollNotification>(
                  onNotification: _onNotification,
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: feedController.feedList.length,
                      itemBuilder: (context, index) {
                        final item = feedController.feedList[index];
                        return FeedListItem(item);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
