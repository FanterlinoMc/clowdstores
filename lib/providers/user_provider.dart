import 'package:clowdstores/Models/user.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:flutter/material.dart';

import '../Data/fire_store_streams.dart';

class UserPro extends ChangeNotifier {
  final bool _isUser = false;
  late String _userId;
  late String _userName;
  late String _photoUrl;
  late String _email;

  /* getters
   */
  bool get isUser => _isUser;
  String get userName => _userName;
  String get photoUrl => _photoUrl;
  String get userId => _userId;
  String get email => _email;

  changeUserName(String value) {
    _userName = value;
  }

changeUserId(String value) {
  _userId = value;
}
changeUserPhotoUrl(String value) {
  _photoUrl = value;
}
changeUserEmail(String value) {
  _email = value;
}
  saveUser() {
    var newUser = UserModel(
      //    isUser: _isUser!,
      userId: _userId,
      email: _email,
      userName: _userName,
      photoUrl: _photoUrl,
    );
    firestoreService.saveUser(newUser);
  }
}

class ChangeUserPro extends ChangeNotifier {
  late bool? _isUser = false;
  late String? _uid;
  // late String userName;
  // late String photoUrl;

  /* getters
   */
  bool get isUser => _isUser!;
  chageUser(bool value) async {
    // final prefs = await SharedPreferences.getInstance();
    // bool? isUser = await prefs.getBool("isUser");
    return _isUser = value;
  }

  changeUserid(String value) {
    _uid = value;
  }

  saveChanageUser() async {
    var newUser = ChangeUseModel(
      isUser: _isUser!,
      userId: _uid,
      // email: fUserE!,
      // userName: fUserN!,
      // photoUrl: fUserP!,
    );

    firestoreService.changeUser(newUser);
  }
}
