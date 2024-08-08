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
  late String _price;
  late dynamic _photoUrl;
  late String _storephotoUrl;
  late String _productType;
  late String _storeId;
  late String _productId;
  late double _latitude;
  late double _longitude;

  ///?User
  late String _userName;
  late String _userPhone;
  late String _useraddress;
  late double _userLat;
  late double _userLgn;

  ///?Order
  late bool _pickUp = false;
  late bool _dropOff = false;
  late String _orderStatus;
  late String _orderId;
  // late String _orderId

  ///?getters
  String get name => _name;
  String get city => _city;
  String get store => _store;
  String get description => _description;
  String get price => _price;
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
  String get useraddress => _useraddress;
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

  changePrice(String value) {
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

  changeUseraddress(String value) {
    _useraddress = value;
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

  // changeOrderId(String value) {
  // _orderId = value;
  // }

  setDlivery({String? storesId}) {
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
      useraddress: useraddress,
      userLat: userLat,
      userLgn: userLgn,
      pickUp: pickUp,
      dropOff: dropOff,
      orderStatus: orderStatus,
      orderId: uuid.v4(),
    );
    firestoreService.setDelivery(setDelivery);
    //  firestoreService.storeOrders(setDelivery,storesId!);
    firestoreService.userOrders(setDelivery);
  }

  setStoreOrders({String? storesId}) {
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
      useraddress: useraddress,
      userLat: userLat,
      userLgn: userLgn,
      pickUp: pickUp,
      dropOff: dropOff,
      orderStatus: orderStatus,
      orderId: uuid.v4(),
    );
    // firestoreService.setDelivery(setDelivery);
    firestoreService.storeOrders(setDelivery, storesId!);
    // firestoreService.userOrders(setDelivery);
  }
}
