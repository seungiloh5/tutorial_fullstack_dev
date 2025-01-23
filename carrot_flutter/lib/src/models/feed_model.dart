class FeedModel {
  late int id;
  late String title;
  int? imageId;
  late String content;
  late int price;

  FeedModel({
    required this.id,
    required this.title,
    required this.content,
    required this.price,
    this.imageId,
  });

  FeedModel.parse(Map<String, dynamic> m) {
    id = m['id'];
    title = m['title'];
    content = m['content'];
    price = m['price'];
    imageId = m['imageId'];
  }

  FeedModel copyWith({
    int? id,
    String? title,
    String? content,
    int? price,
    int? imageId,
  }) {
    return FeedModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      price: price ?? this.price,
      imageId: imageId ?? this.imageId,
    );
  }
}
