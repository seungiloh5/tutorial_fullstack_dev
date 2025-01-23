import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/feed/edit.dart';
import '../../models/feed_model.dart';

// 이미지 크기
const double _imageSize = 110;

class FeedListItem extends StatelessWidget {
  final FeedModel data;
  const FeedListItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => FeedEdit(item: item)),
        // );
        Get.to(() => FeedEdit(model: data));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 영역
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/pikachu_flutter.png',
                    fit: BoxFit.cover,
                    width: _imageSize,
                    height: _imageSize,
                  ),
                  // child: Image.network(
                  //   "https://example.com/image.jpg",
                  //   width: _imageSize,
                  //   height: _imageSize,
                  //   fit: BoxFit.cover,
                  // ),
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
                              '동네이름',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text('N 분전', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        Text(data.price.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                // 기타 영역
                IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.more_vert, color: Colors.grey, size: 16),
                ),
              ],
            ),
            Positioned(
              right: 10,
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
                    '1',
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
                    '1',
                    style: TextStyle(color: Colors.grey),
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
