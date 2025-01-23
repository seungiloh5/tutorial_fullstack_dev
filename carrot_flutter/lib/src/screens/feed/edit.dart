import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';
import '../../models/feed_model.dart';
import '../../widgets/forms/label_textfield.dart';

class FeedEdit extends StatefulWidget {
  final FeedModel model;
  const FeedEdit({required this.model, super.key});

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  final feedController = Get.put(FeedController());
  int? imageId;
  late int _feedId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  _submit() async {
    final result = await feedController.feedUpdate(
      _feedId,
      _titleController.text,
      _priceController.text,
      _contentController.text,
      imageId,
    );
    if (result) {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    _feedId = widget.model.id;
    _titleController.text = widget.model.title;
    _priceController.text = widget.model.price.toString();
    _contentController.text = widget.model.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('물건정보 수정')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LabelTextField(
                    label: '제목',
                    hintText: '제목',
                    controller: _titleController,
                  ),
                  LabelTextField(
                    label: '가격',
                    hintText: '가격을 입력해주세요.',
                    controller: _priceController,
                  ),
                  LabelTextField(
                    label: '자세한 설명',
                    hintText: '자세한 설명을 입력하세요',
                    controller: _contentController,
                    maxLines: 6,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('수정 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
