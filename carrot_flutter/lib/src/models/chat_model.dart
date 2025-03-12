class ChatModel {
  late int id;
  late int roomId;
  late int userId;
  late String content;
  DateTime? createdAt;

  ChatModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.content,
    this.createdAt,
  });

  ChatModel.parse(Map<String, dynamic> m) {
    id = m['id'];
    roomId = m['roomId'];
    userId = m['userId'];
    content = m['content'];
    createdAt = m['createdAt'] != null ? DateTime.parse(m['created_at']) : null;
  }
}
