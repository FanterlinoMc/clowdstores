import 'dart:convert';

import '../Data/fire_store_streams.dart';

class UserModel {
  // final bool isUser;
  final String? userName;
  final String? userId;
  final String? email;
  final String? photoUrl;

  UserModel({
    //required this.isUser,
    required this.userName,
    required this.userId,
    required this.email,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      //'isStoreOwner': isUser,
      'userId': userId,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      //  isUser: map['isStoreOwner'] ?? '',
      userName: map['userName'] ?? '',
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

class ChangeUseModel {
  final bool isUser;
  // final String userName;
  final String? userId;
  // final String email;
  // final String photoUrl;

  ChangeUseModel({
    required this.isUser,
    // required this.userName,
    required this.userId,
    // required this.email,
    // required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'userName': fUserN,
      'isStoreOwner': isUser,
      'userId': userId,
      // 'email': fUserE,
      // 'photoUrl': fUserP,
    };
  }

  factory ChangeUseModel.fromMap(Map<String, dynamic> map) {
    return ChangeUseModel(
      isUser: map['isStoreOwner'] ?? '',
      // userName: map['userName'] ?? '',
      userId: map['userId'] ?? '',
      // email: map['email'] ?? '',
      // photoUrl: map['photoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeUseModel.fromJson(String source) =>
      ChangeUseModel.fromMap(json.decode(source));
}
