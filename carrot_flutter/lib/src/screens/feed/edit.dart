import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';

class FeedEdit extends StatelessWidget {
  final Map item;

  FeedEdit({Key? key, required this.item}) : super(key: key);

  final FeedController feedController = Get.find<FeedController>();

  @override
  Widget build(BuildContext context) {
    // 컨트롤러를 로컬 변수로 선언하고 초기화
    final titleController = TextEditingController(text: item['title']);
    final priceController =
        TextEditingController(text: item['price'].toString());

    // 수정 데이터를 처리하는 함수
    void _submit() {
      final updatedItem = {
        ...item,
        'title': titleController.text,
        'price': int.tryParse(priceController.text) ?? item['price'],
      };

      feedController.updateData(updatedItem);

      Get.back();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('물품 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: '가격',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('수정하기'),
            ),
          ],
        ),
      ),
    );
  }
}
