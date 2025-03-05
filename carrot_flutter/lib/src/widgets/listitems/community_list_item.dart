import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/community_model.dart';
import '../../screens/community/show.dart';
import '../../shared/timeutil.dart';
import '../basic/image_box.dart';

class CommunityListItem extends StatelessWidget {
  final CommunityModel model;
  const CommunityListItem(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CommunityShow(model.id));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      model.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.title,
                    style: const TextStyle().copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle().copyWith(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    TimeUtil.parse(model.createdAt),
                    style: const TextStyle()
                        .copyWith(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            ImageBox(model.imageUrl, size: 80),
          ],
        ),
      ),
    );
  }
}
