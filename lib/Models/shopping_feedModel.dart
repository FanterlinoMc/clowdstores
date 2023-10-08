import 'dart:convert';

class ShoppingFeedModel {
  // final String postTitle;
  final postImage;
  final String postContent;
  final String postCategory;
  final String stroreProfile;
  // final double likePost;
  final String storeName;
  final String postId;
  final String userpostId;
  // final String videoUrl;
  ShoppingFeedModel({
    required this.stroreProfile,
    // required this.likePost,
    required this.storeName,
    required this.postId,
    this.postImage,
    required this.postContent,
    required this.postCategory,
    required this.userpostId,
    // required this.videoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'postCategory': postCategory,
      'postImage': postImage,
      'postContent': postContent,
      'storeName': storeName,
      'storeProfile': stroreProfile,
      // // 'likePost': likePost,
      'postId': postId,
      'userpostId': userpostId,
      // // 'videoUrl': videoUrl,
    };
  }

  factory ShoppingFeedModel.fromMap(Map<String, dynamic> map) {
    return ShoppingFeedModel(
      // postTitle: map['postTitle'] ?? '',
      postImage: map['postImage'] ?? '',
      postContent: map['postContent'] ?? '',
      postCategory: map['postCategory'] ?? '',
      storeName: map['storeName'] ?? '',
      stroreProfile: map['stroreProfile'] ?? '',
      // // likePost: map['likePost'] ?? '',
      postId: map['postId'] ?? '',
      userpostId: map['userpostId'] ?? '',
      // // videoUrl: map['videoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingFeedModel.fromJson(String source) =>
      ShoppingFeedModel.fromMap(json.decode(source));
}
