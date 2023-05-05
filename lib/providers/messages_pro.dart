import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../Models/messages_model.dart';
import '../helpers/change_notifiiers.dart';

class MessagesPro extends ChangeNotifier {
  final uuid = const Uuid();
  final auth = FirebaseAuth.instance.currentUser;

//getters
  late String? _roomId;
  String? _message;

  late bool? _isMe;
  late bool? _isNotMe;

  late String? _photoUrl;

  late String? _messagephotoUrl;
  late String? _name;
  late String? _senderId;
  late String? _userId;

  late Timestamp newMassage;

  ///getters

  bool? get isMe => _isMe;
  bool? get isNotMe => _isNotMe;
  String? get roomId => _roomId;
  String? get message => _message;
  String? get photoUrl => _photoUrl;

  String get messagephotoUrl => _messagephotoUrl!;

  String get senderId => _senderId!;
  String get userId => _userId!;
  String get name => _name!;

  Timestamp get onCreated => newMassage;
  //setters

  ifIsMe({String? value}) async {
    // _isMe = true;
    if (value == auth!.uid) {
      _isMe = true;
    } else {
      _isMe = false;
    }
    if (value != auth!.uid) {
      _isNotMe = true;
    } else {
      _isNotMe = false;
    }
  }

  changeName(String value) {
    _name = value;
  }

  changePhotoUrl(String value) {
    _photoUrl = value;
  }

  changeMessage(String value) {
    _message = (value);
    notifyListeners();
  }

  changeRoomId() {
    _roomId = uuid.v4();
    notifyListeners();
  }

  saveRoom(
      {String? userId,
      String? senderId,
      String? roomId,
      String? photoUrl,
      String? userName,
      String? storeName}) {
    var newUserRoom = ChatRoomModel(
        isMe: _isMe,
        userId: userId,
        senderId: senderId,
        //  storeName: userName,
        message: _message ?? "",
        photoUrl: auth!.photoURL,
        // storePhotoUrl: storePhotoUrl,
        name: auth!.displayName,
        newMassage: Timestamp.now(),
        roomId: _roomId);
    var newStoreRoom = ChatRoomModel(
        isMe: _isNotMe,
        userId: userId,
        senderId: senderId,
        name: storeName,
        message: _message ?? "",
        //userPhotoUrl: auth!.photoURL,
        photoUrl: photoUrl,
        // userName: storeName,
        newMassage: Timestamp.now(),
        roomId: _roomId);

    firestoreService.chatListUid(newStoreRoom, roomId);
    firestoreService.chatList(newUserRoom, senderId, roomId);
  }

  updateRoom({
    String? updateRoomId,
    String? updateMessage,
    String? updateUserId,
    String? updateSenderId,
  }) {
    var updateStoreRoom = UpdateMessagesModel(
        message: updateMessage,
        newMassage: Timestamp.now(),
        roomId: updateRoomId);
    var updateUserRoom = UpdateMessagesModel(
        message: updateMessage,
        newMassage: Timestamp.now(),
        roomId: updateRoomId);

    firestoreService.updateRoomUid(updateStoreRoom, updateRoomId, updateUserId);
    firestoreService.updateRoom(updateUserRoom, updateSenderId, updateRoomId);
  }

  ChatRoom({String? roomId, bool? isMe}) {
    var newMessages = MessagesModel(
        isMe: _isMe,
        // userId: userId,
        // senderId: senderId,
        name: _name ?? "",
        message: _message ?? "",
        //  photoUrl: auth!.photoURL,
        newMassage: Timestamp.now(),
        // newMassage: Timestamp.now(),
        roomId: roomId);

    firestoreService.chatRoom(messagesModel: newMessages, roomId: roomId);
  }
}
