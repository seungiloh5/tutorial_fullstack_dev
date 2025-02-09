import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/listitems/chat_list_item.dart';
import '../../controllers/chat_controller.dart';

class ChatShow extends StatefulWidget {
  final int roomId;
  const ChatShow(this.roomId, {super.key});

  @override
  State<ChatShow> createState() => _ChatShowState();
}

class _ChatShowState extends State<ChatShow> {
  final ChatController chatController = Get.put(ChatController());
  final _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatController.scrollController = _scrollController;
    chatController.enterRoom(widget.roomId);
  }

  @override
  void dispose() {
    chatController.disconnect();
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _textEditingController.text;
    if (message.isNotEmpty) {
      chatController.sendMessage(widget.roomId, message);
      _textEditingController.clear();
      chatController.scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(child: Obx(() {
            if (chatController.chatList.isEmpty) {
              return const Center(
                child: Text(
                  '채팅이 없습니다',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            } else {
              return ListView.builder(
                controller: _scrollController,
                itemCount: chatController.chatList.length,
                itemBuilder: (context, index) {
                  return ChatListItem(chatController.chatList[index]);
                },
              );
            }
          })),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _textEditingController,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: '메시지 보내기',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (value) {
                        _sendMessage();
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
