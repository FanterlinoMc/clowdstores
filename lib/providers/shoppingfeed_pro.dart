import 'package:flutter/material.dart';

import '../Models/sfeedModel.dart';
import '../helpers/change_notifiiers.dart';

class ShoppingFeedProvider with ChangeNotifier {
  late String _postTitle;
  late String _postImage;
  late String _postcontent;
  late String _postCate;

  String get postTitle => _postTitle;
  String get postImage => _postImage;
  String get postcontent => _postcontent;
  String get postCate => _postCate;

  changePostTitle(String value) {
    _postTitle = value;
  }

  changePostImage(String value) {
    _postImage = value;
  }

  changePostcontent(String value) {
    _postcontent = value;
  }

  changePostCategory(String value) {
    _postCate = value;
  }

  void savePost() {
    var savePost = ShoppingFeedModel(
        postTitle: postTitle,
        postImage: postImage,
        postContent: postcontent,
        postCate: postCate);
    firestoreService.savepost(savePost);
  }
}
