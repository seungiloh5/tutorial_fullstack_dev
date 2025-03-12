import 'package:carrot_flutter/src/models/feed_model.dart';

import 'user_model.dart';

class RoomModel {
  late int id;
  late String title;
  late UserModel client;
  late FeedModel feed;
  late String lastMessage;
  DateTime? updatedAt;

  RoomModel({
    required this.id,
    required this.title,
    required this.client,
    required this.feed,
    required this.lastMessage,
    this.updatedAt,
  });

  RoomModel.parse(Map<String, dynamic>? m) {
    if (m == null) {
      id = 0;
      title = 'Untitled Room';
      client = UserModel(id: 0, name: 'Unknown');
      feed = FeedModel(
        id: 0,
        title: 'Untitled Feed',
        content: 'No content available',
        price: 0,
        createdAt: DateTime.now(),
        isMe: false,
        isFavorite: false,
      );
      lastMessage = '';
      updatedAt = null;
      return;
    }

    id = m['id'] ?? 0;
    title = m['title'] ?? 'Untitled Room';

    client = (m['client'] != null)
        ? UserModel.parse(m['client'])
        : UserModel(id: 0, name: 'Unknown');

    feed = (m['feed'] != null)
        ? FeedModel.parse(m['feed'])
        : FeedModel(
            id: 0,
            title: 'Untitled Feed',
            content: 'No content available',
            price: 0,
            createdAt: DateTime.now(),
            isMe: false,
            isFavorite: false,
          );

    lastMessage = m['lastMessage'] ?? '';
    updatedAt = m['updatedAt'] != null
        ? DateTime.tryParse(m['updatedAt']) ?? DateTime.now()
        : null;
  }
}
