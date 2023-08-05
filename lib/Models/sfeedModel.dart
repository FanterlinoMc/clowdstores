import 'dart:convert';

class ShoppingFeedModel {
  final String postTitle;
  final String postImage;
  final String postContent;
  final String postCate;
  ShoppingFeedModel({
    required this.postTitle,
    required this.postImage,
    required this.postContent,
    required this.postCate,
  });

  Map<String, dynamic> toMap() {
    return {
      'postTitle': postTitle,
      'postImage': postImage,
      'postContent': postContent,
      'postCate': postCate,
    };
  }

  factory ShoppingFeedModel.fromMap(Map<String, dynamic> map) {
    return ShoppingFeedModel(
      postTitle: map['postTitle'] ?? '',
      postImage: map['postImage'] ?? '',
      postContent: map['postContent'] ?? '',
      postCate: map['postCate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingFeedModel.fromJson(String source) =>
      ShoppingFeedModel.fromMap(json.decode(source));
}
