import '../../controllers/feed_controller.dart';
import '../../widgets/forms/label_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedCreate extends StatefulWidget {
  const FeedCreate({super.key});

  @override
  State<FeedCreate> createState() => _FeedCreateState();
}

class _FeedCreateState extends State<FeedCreate> {
  final feedController = Get.put(FeedController());
  int? imageId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  _submit() async {
    final result = await feedController.feedCreate(
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 물건 팔기')),
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
                  // 피트 타이틀
                  LabelTextField(
                    label: '제목',
                    hintText: '제목',
                    controller: _titleController,
                  ),
                  // 가격
                  LabelTextField(
                    label: '가격',
                    hintText: '가격을 입력해주세요.',
                    controller: _priceController,
                  ),
                  // 설명
                  LabelTextField(
                    label: '자세한 설명',
                    hintText: '자세한 설명을 입력하세요.',
                    controller: _contentController,
                    maxLines: 6,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('작성 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
