import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Data/fire_store_streams.dart';

class ChatRoomModel {
  final String? userId;
  final bool? isMe;
  final Timestamp? newMassage;
  final String? roomId;
  final String? photoUrl;

  final String? name;
  final String? message;
  final String? senderId;

  ChatRoomModel({
    this.isMe,
    this.userId,
    this.newMassage,
    this.roomId,
    this.name,
    this.photoUrl,
    this.message,
    this.senderId,
  });
  final auth = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> toMap() {
    return {
      'isMe': isMe,
      'userId': uid,
      'senderId': senderId,
      'newMassage': newMassage,
      'roomId': roomId,
      'name': name,
      'photoUrl': photoUrl,
      'message': message,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      isMe: map['isMe'],
      senderId: map['senderId'],
      userId: map['userId'],
      newMassage: map['newMassage'],
      roomId: map['roomId'],
      photoUrl: map['photoUrl'],
      name: map['name'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomModel.fromJson(String source) =>
      ChatRoomModel.fromMap(json.decode(source));
}

//??? MessageModel

class MessagesModel {
// final String? userId;
  final bool? isMe;
  final Timestamp? newMassage;
  final String? roomId;

  final String? name;
  final String? message;

  MessagesModel({
    this.isMe,
    this.newMassage,
    this.roomId,
    this.name,
    this.message,
  });
  final auth = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> toMap() {
    return {
      'isMe': isMe,
      // 'userId': uid,
      // 'senderId': senderId,
      'newMassage': newMassage,
      'roomId': roomId,
      'name': name,

      'message': message,
    };
  }

  factory MessagesModel.fromMap(Map<String, dynamic> map) {
    return MessagesModel(
      isMe: map['isMe'],
      newMassage: map['newMassage'],
      roomId: map['roomId'],
      name: map['name'],
      message: map['message'],
    );
  }
  Map<String, dynamic> toMapUpdate() {
    return {
      'newMassage': newMassage,
      'roomId': roomId,
      'message': message,
    };
  }

  factory MessagesModel.fromMapUpdate(Map<String, dynamic> map) {
    return MessagesModel(
      roomId: map['roomId'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesModel.fromJson(String source) =>
      MessagesModel.fromMap(json.decode(source));
}

class UpdateMessagesModel {
  final Timestamp? newMassage;
  final String? roomId;

  final String? message;

  UpdateMessagesModel({
    this.newMassage,
    this.roomId,
    this.message,
  });

  Map<String, dynamic> toMapUpdate() {
    return {
      'newMassage': newMassage,
      'roomId': roomId,
      'message': message,
    };
  }

  factory UpdateMessagesModel.fromMapUpdate(Map<String, dynamic> map) {
    return UpdateMessagesModel(
      roomId: map['roomId'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMapUpdate());

  factory UpdateMessagesModel.fromJson(String source) =>
      UpdateMessagesModel.fromMapUpdate(json.decode(source));
}
