import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Data/fire_store_streams.dart';
import '../Models/shopping_feedModel.dart';
import '../helpers/change_notifiiers.dart';

class ShoppingFeedProvider with ChangeNotifier {
  final postuid = const Uuid();
  // late String _postTitle;
  late String _postImage;
  late String _postcontent;
  late String _category;
  late String _storeProfile;
  late String _storeName;
  // late double _likePost;
  late String _postId;
  late String _userpostId;
  late String _onCreated;

  // String get postTitle => _postTitle;
  String get postImage => _postImage;
  String get postcontent => _postcontent;
  String get category => _category;
  String get storeProfile => _storeProfile;
  String get storeName => _storeName;
  // double get likePost => _likePost;
  String get postId => _postId;
  String get userpostId => _userpostId;
  String get onCreated => _onCreated;

  changePostImage(String value) {
    _postImage = value;
  }

  changePostcontent(String value) {
    _postcontent = value;
  }

  changePostCategory(String value) {
    _category = value;
  }

  changeStoreName(String value) {
    _storeName = value;
  }

  changeStoreProfile(String value) {
    _storeProfile = value;
  }

  changeLikePost({double value = 0}) {
    // _likePost = value + 1;
  }

  // changeVideoUrl(String value) {
  //   _videoUrl = value;
  // }

  void savePost() {
    var savePost = ShoppingFeedModel(
      onCreated: Timestamp.now(),
      postId: postuid.v4(),
      userpostId: uid!,
      postImage: postImage,
      postContent: postcontent,
      postCategory: category,
      storeName: storeName,
      stroreProfile: storeProfile,
      // likePost: likePost,
    );
    firestoreService.savepost(savePost);
  }
}
