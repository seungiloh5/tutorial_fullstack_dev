import 'package:carrot_flutter/src/models/room_model.dart';

import 'user_model.dart';
import 'feed_model.dart';

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

  RoomModel.parse(Map<String, dynamic> m) {
    id = m['id'];
    title = m['title'];
    client = UserModel.parse(m['client']);
    feed = FeedModel.parse(m['feed']);
    lastMessage = m['lastMessage'];
    updatedAt = m['updatedAt'] != null ? DateTime.parse(m['updatedAt']) : null;
  }
}
