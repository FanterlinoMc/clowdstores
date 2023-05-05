import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../Models/review_model.dart';
import '../helpers/change_notifiiers.dart';

class ReviewProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance.currentUser;
  final uuid = const Uuid();

//setters to set the value to firestore

  late String _review;
  late String _storeId;
//  late String _reviewID;
  // late bool isMe;

  String get review => _review;
  String get storeId => _storeId;
  //String get reviewID => _reviewID;

  changeReview(String value) {
    _review = (value);
    notifyListeners();
  }

  changeStoerId(String value) {
    _storeId = (value);
    notifyListeners();
  }

  saveReview(String storeId) {
    var newReview = ReviewModel(
      review: review,
      name: auth!.displayName,
      userPic: auth!.photoURL,
      storeId: storeId,
      reviewID: uuid.v4(),
    );
    firestoreService.addReview(newReview, storeId);
  }
}
