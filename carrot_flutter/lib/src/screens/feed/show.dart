import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/feed_controller.dart';
import '../../controllers/chat_controller.dart';
import '../../screens/chat/show.dart';
import '../../widgets/listitems/user_list_item.dart';
import '../../shared/timeutil.dart';

class FeedShow extends StatefulWidget {
  final int feedId;
  const FeedShow(this.feedId, {super.key});

  @override
  State<FeedShow> createState() => _FeedShowState();
}

class _FeedShowState extends State<FeedShow> {
  final FeedController feedController = Get.find<FeedController>();
  final ChatController chatController = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    feedController.feedShow(widget.feedId);
  }

  _chat() async {
    int id = await chatController.newRoom(widget.feedId);
    Get.to(() => ChatShow(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Obx(() {
            final feed = feedController.currentFeed.value;

            return SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 3,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: feed != null
                    ? Image.asset(
                        'assets/images/no_image.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                      )
                    : null,
              ),
            );
          }),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Obx(() {
              if (feedController.currentFeed.value != null) {
                final textTheme = Theme.of(context).textTheme;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 본문 내용
                      UserListItem(feedController.currentFeed.value!.writer!),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feedController.currentFeed.value!.title,
                              style: textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              TimeUtil.parse(
                                  feedController.currentFeed.value?.createdAt),
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              feedController.currentFeed.value!.content,
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          final feed = feedController.currentFeed.value;
          if (feed == null) {
            print('[FeedShow] 피드 불러오기 실패');
            return const SizedBox();
          }
          return Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await feedController.toggleFavorite(feed.id);
                  },
                  icon: Icon(
                    feed.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: feed.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${feed.price} 원",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Visibility(
                  visible: !feed.isMe,
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onPressed: _chat,
                      child: const Text("채팅하기"),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
