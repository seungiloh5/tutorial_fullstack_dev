import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';
import '../../models/feed_model.dart';
import '../../screens/feed/show.dart';
import '../modal/confirm_modal.dart';
import '../modal/more_bottom.dart';
import '../../screens/feed/edit.dart';
import '../../shared/timeutil.dart';

// 이미지 크기
const double _imageSize = 110;

class FeedListItem extends StatelessWidget {
  final FeedModel data;
  const FeedListItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final FeedController feedController = Get.put(FeedController());
    return InkWell(
      onTap: () {
        Get.to(() => FeedShow(data.id));
        // Get.to(() => FeedEdit(model: data)); // 피드 수정
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Container(width: 100, height: 100, color: Colors.blue),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 영역
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/no_image.png',
                    fit: BoxFit.cover,
                    width: _imageSize,
                    height: _imageSize,
                  ),
                ),
                // 정보 영역
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            Text(
                              TimeUtil.parse(data.createdAt),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(
                          data.price.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                // 기타 영역
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return MoreBottomModal(
                          delete: data.isMe
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ConfirmModal(
                                        title: '삭제하기',
                                        content:
                                            '이 글을 삭제하시겠습니까? 삭제한 글은 다시 볼 수 없습니다.',
                                        confirmText: '삭제하기',
                                        confirmAction: () async {
                                          bool result = await feedController
                                              .feedDelete(data.id);
                                          if (result) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }
                                        },
                                        cancel: () {
                                          Navigator.pop(context); // dialog 닫기
                                        },
                                      );
                                    },
                                  );
                                }
                              : null,
                          cancelTap: () {
                            Navigator.pop(context);
                          },
                          hideTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmModal(
                                    title: '글 숨기기',
                                    content: '이 글을 숨기시겠습니까? 숨긴 글은 다시 볼 수 없습니다.',
                                    confirmText: '숨기기',
                                    confirmAction: () {
                                      // 여기에 글을 숨기는 로직을 구현합니다.
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    cancel: () {
                                      Navigator.pop(context); // dialog 닫기
                                    },
                                  );
                                });
                          },
                        );
                      },
                    );
                  },
                  icon:
                      const Icon(Icons.more_vert, color: Colors.grey, size: 16),
                ),
              ],
            ),
            // 채팅, 관심 물건 창 배치
            Positioned(
              right: 12,
              bottom: 0,
              child: Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '${data.chatCount}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '${data.favoriteCount}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
