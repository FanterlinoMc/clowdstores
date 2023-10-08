import 'package:clowdstores/Models/user.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:flutter/material.dart';

import '../Data/fire_store_streams.dart';

class UserPro extends ChangeNotifier {
  final bool _isUser = false;
  late String? userId;
  late String? userName;
  late String? photoUrl;

  /* getters
   */
  bool get isUser => _isUser;
  

  saveUser() {
    var newUser = UserModel(
      //    isUser: _isUser!,
      uid: uid,
      email: fUserE,
      userName: fUserN,
      photoUrl: fUserP,
    );
    firestoreService.saveUser(newUser);
  }
}

class ChangeUserPro extends ChangeNotifier {
  late bool? _isUser = false;
  //late String uid;
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

  saveChanageUser() {
    var newUser = ChangeUseModel(
      isUser: _isUser!,
      userId: uid,
      // email: fUserE!,
      // userName: fUserN!,
      // photoUrl: fUserP!,
    );
    firestoreService.changeUser(newUser);
  }
}
