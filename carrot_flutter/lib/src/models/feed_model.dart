import '../shared/global.dart';
import 'user_model.dart';

class FeedModel {
  late int id;
  late String title;
  int? imageId;
  late String content;
  late int price;
  DateTime? createdAt;
  bool isMe = false;
  UserModel? writer;

  get imageUrl => (imageId != null)
      ? "${Global.baseUrl}/file/$imageId"
      : "https://example.com/image.jpg";

  FeedModel({
    required this.id,
    required this.title,
    required this.content,
    required this.price,
    required this.createdAt,
    required this.isMe,
    this.imageId,
    this.writer,
  });

  FeedModel.parse(Map<String, dynamic> m) {
    id = m['id'];
    title = m['title'];
    content = m['content'];
    price = m['price'];
    imageId = m['imageId'];
    isMe = m['is_me'] ?? false;
    createdAt = DateTime.parse(m['created_at']);
    writer = (m['writer'] != null) ? UserModel.parse(m['writer']) : null;
  }

  FeedModel copyWith({
    int? id,
    String? title,
    String? content,
    int? price,
    int? imageId,
    bool? isMe,
    DateTime? createdAt,
    UserModel? writer,
  }) {
    return FeedModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      price: price ?? this.price,
      imageId: imageId ?? this.imageId,
      createdAt: createdAt ?? this.createdAt,
      writer: writer ?? this.writer,
      isMe: isMe ?? this.isMe,
    );
  }
}
