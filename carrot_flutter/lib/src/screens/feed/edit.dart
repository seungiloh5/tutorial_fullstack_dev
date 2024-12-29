import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';
import '../../models/feed_model.dart';

class FeedEdit extends StatefulWidget {
  final FeedModel item;

  const FeedEdit({Key? key, required this.item}) : super(key: key);

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  final FeedController feedController = Get.find<FeedController>();

  @override
  void initState() {
    super.initState();
    // TextEditingController 초기화
    titleController = TextEditingController(text: widget.item.title);
    priceController = TextEditingController(text: widget.item.price.toString());
  }

  @override
  void dispose() {
    // TextEditingController 해제
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _submit() {
    final updatedItem = FeedModel.parse({
      'id': widget.item.id,
      'title': titleController.text,
      'content': widget.item.content,
      'price': int.tryParse(priceController.text) ?? widget.item.price,
    });

    feedController.updateData(updatedItem);

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
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
