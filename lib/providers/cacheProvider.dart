import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';

class CacheProvider with ChangeNotifier {
  late dynamic _routeId = "";
  late dynamic _subRoute = "";
  late dynamic _collectionName = "";
  late dynamic _userId = "";
  late dynamic _dcoId = "";
  late dynamic _randomString = "";
  late dynamic _randomMap = "";
  late dynamic _city = "";

  late dynamic _uid = "";
  late dynamic _name = "";

  late dynamic _photoUrl = "";
  late dynamic _roomId = "";
  late dynamic _senderId = "";
  late double _lat = 0;
  late double _lng = 0;
  late bool? _isMe = false;

  dynamic get routeId => _routeId;
  dynamic get subRoute => _subRoute;
  dynamic get collectionName => _collectionName;
  dynamic get userId => _userId;
  dynamic get dcoId => _dcoId;
  dynamic get randomString => _randomString;
  dynamic get randomMap => _randomMap;
  dynamic get city => _city;

  dynamic get uid => _uid;
  dynamic get name => _name;
  dynamic get photoUrl => _photoUrl;

  dynamic get roomId => _roomId;
  dynamic get senderId => _senderId;
  double get lat => _lat = 29.9712422;
  double get lng => _lng = 31.2740701;
  bool? get isMe => _isMe!;

  chanageRouterId(dynamic value) {
    _routeId = value;
  }

  chanagecity(dynamic value) {
    _city = value;
  }

  chanagesubRouterId(dynamic value) {
    _subRoute = value;
  }

  chanageCollectionName(dynamic value) {
    _collectionName = value;
  }

  chanageUserId(dynamic value) {
    _userId = value;
  }

  chanageDocId(dynamic value) {
    _dcoId = value;
  }

  chanageRandomString(dynamic value) {
    _randomString = value;
  }

  chanageUid(dynamic value) {
    _uid = value;
  }

  chanageName(dynamic value) {
    _name = value;
  }

  chanagePhotoUrl(dynamic value) {
    _photoUrl = value;
  }

  chanageRoomId(dynamic value) {
    _roomId = value;
  }

  chanageSenderId(dynamic value) {
    _senderId = value;
  }

  chanageIsMe(bool value) {
    _isMe = value;
  }

  chanageRandomMap(String value) {
    _randomMap = value;
  }

  chanageLat(double value) {
    _lat = value;
  }

  chanageLng(double value) {
    _lng = value;
  }

  Future routeSates() async {
    WriteCache.setString(key: "routeId", value: _routeId);
    WriteCache.setString(key: "subRouteId", value: _subRoute);
    WriteCache.setString(key: "collectionId", value: _collectionName);
    WriteCache.setString(key: "userId", value: _userId);
    WriteCache.setString(key: "docId", value: _dcoId);
    WriteCache.setString(key: "randomString", value: _randomString);
    WriteCache.setString(key: "randomMap", value: _randomMap);

    WriteCache.setString(key: "name", value: _name);
    WriteCache.setString(key: "city", value: _city);

    WriteCache.setString(key: "photoUrl", value: _photoUrl);

    WriteCache.setString(key: "roomId", value: _roomId);
    WriteCache.setString(key: "senderId", value: _senderId);
    WriteCache.setString(key: "uid", value: _uid);
    WriteCache.setDouble(key: "lat", value: _lat);
    WriteCache.setDouble(key: "lng", value: _lng);
    WriteCache.setBool(key: "isMe", value: _isMe!);

    // var crouteSate = ClowdRouterModel(
    //   routerId: _routeId,
    //   subRouter: _subRoute,
    // );

    //firestoreService.routerSate(crouteSate);
  }
}
