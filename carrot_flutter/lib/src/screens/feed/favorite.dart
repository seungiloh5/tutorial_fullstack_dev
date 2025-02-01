import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';
import '../../widgets/listitems/feed_list_item.dart';

class FeedFavorite extends StatefulWidget {
  const FeedFavorite({super.key});

  @override
  State<FeedFavorite> createState() => _FeedFavoriteState();
}

class _FeedFavoriteState extends State<FeedFavorite> {
  final FeedController feedController = Get.put(FeedController());
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    feedController.favoriteIndex();
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.favoriteIndex();
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.favoriteIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('관심목록'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (feedController.favoriteList.isEmpty) {
                return const Center(
                  child: Text('결과가 없습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                );
              } else {
                return NotificationListener<ScrollNotification>(
                  onNotification: _onNotification,
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: feedController.favoriteList.length,
                      itemBuilder: (context, index) {
                        return FeedListItem(feedController.favoriteList[index]);
                      },
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
