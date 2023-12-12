import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Models/delivery_model.dart';
import '../helpers/change_notifiiers.dart';

class Delivery with ChangeNotifier {
  // final auth = FirebaseAuth.instance.currentUser;
  final uuid = const Uuid();

  ///?Store + Product
  late String _name;
  late String _city;
  late String _store;
  late String _description;
  late double _price;
  dynamic _photoUrl;
  late String _storephotoUrl;
  late String _productType;
  late String _storeId;
  late String _productId;
  late double _latitude;
  late double _longitude;

  ///?User
  late String _userName;
  late String _userPhone;
  late String _userAddrees;
  late double _userLat;
  late double _userLgn;

  ///?Order
  late bool _pickUp;
  late bool _dropOff;
  late String _orderStatus;
  late String _orderId;
  // late String _orderId

  ///?getters
  String get name => _name;
  String get city => _city;
  String get store => _store;
  String get description => _description;
  double get price => _price;
  String get photoUrl => _photoUrl;
  String get storephotoUrl => _storephotoUrl;
  String get productType => _productType;
  String get storeId => _storeId;
  String get productId => _productId;
  double get latitude => _latitude;
  double get longitude => _longitude;

  ///?User
  String get userName => _userName;
  String get userPhone => _userPhone;
  String get userAddrees => _userAddrees;
  double get userLat => _userLat;
  double get userLgn => _userLgn;

  ///?order
  bool get pickUp => _pickUp;
  bool get dropOff => _dropOff;
  String get orderStatus => _orderStatus;
  String get orderId => _orderId;
  // bool get _dropOff => _dropOff;

  changeName(String value) {
    _name = value;
  }

  changeCity(String value) {
    _city = value;
  }

  changeStore(String value) {
    _store = value;
  }

  changeDescription(String value) {
    _description = value;
  }

  changePrice(double value) {
    _price = value;
  }

  changPhotoUrl(String value) {
    _photoUrl = value;
  }

  changeStorephotoUrl(String value) {
    _storephotoUrl = value;
  }

  changeProductType(String value) {
    _productType = value;
  }

  changeStoreId(String value) {
    _storeId = value;
  }

  changeProductId(String value) {
    _productId = value;
  }

  changeLatitude(double value) {
    _latitude = value;
  }

  changeLongitude(double value) {
    _longitude = value;
  }

  ///? user

  changeUserName(String value) {
    _userName = value;
  }

  changeUserPhone(String value) {
    _userPhone = value;
  }

  changeUserAddrees(String value) {
    _userAddrees = value;
  }

  changeUserLat(double value) {
    _userLat = value;
  }

  changeUserLgn(double value) {
    _userLgn = value;
  }

  ///?Order
  changePickUp(bool value) {
    _pickUp = value;
  }

  changeDropOff(bool value) {
    _dropOff = value;
  }

  changeOrderStatus(String value) {
    _orderStatus = value;
  }

  changeOrderId(String value) {
    _orderId = value;
  }

  setDlivery() {
    var setDelivery = DeliveryModel(
      name: name,
      city: city,
      store: store,
      description: description,
      price: price,
      photoUrl: photoUrl,
      storephotoUrl: storephotoUrl,
      productType: productType,
      storeId: storeId,
      productId: productId,
      latitude: latitude,
      longitude: longitude,
      userName: userName,
      userPhone: userPhone,
      userAddrees: userAddrees,
      userLat: userLat,
      userLgn: userLgn,
      pickUp: pickUp,
      dropOff: dropOff,
      orderStatus: orderStatus,
      orderId: uuid.v4(),
    );
    firestoreService.setDelivery(setDelivery);
  }
}
