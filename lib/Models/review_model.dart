import 'package:firebase_auth/firebase_auth.dart';

class ReviewModel {
  final String review;
  final String? name;
  final String? userPic;
  final String storeId;
  final String reviewID;

  ReviewModel({
    required this.review,
    required this.name,
    required this.userPic,
    required this.storeId,
    required this.reviewID,
  });
  final auth = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> messageMap() {
    return {
      "nmae": auth!.displayName,
      "review": review,
      "userPic": auth!.photoURL,
      "storeId": storeId,
      "reviewID": reviewID,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "nmae": auth!.displayName,
      "review": review,
      "userPic": auth!.photoURL,
      "storeId": storeId,
      "reviewID": reviewID,
    };
  }
}
