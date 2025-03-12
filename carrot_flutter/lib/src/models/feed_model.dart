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
  bool isFavorite = false;
  int favoriteCount = 0;
  int chatCount = 0;

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
    required this.isFavorite,
    this.favoriteCount = 0,
    this.chatCount = 0,
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
    isFavorite = m['is_favorited'] ?? false;
    favoriteCount = m['favorite_count'] ?? 0;
    chatCount = m['chat_count'] ?? 0;
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
    bool? isFavorite,
    int? favoriteCount,
    int? chatCount,
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
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      chatCount: chatCount ?? this.chatCount,
    );
  }
}
