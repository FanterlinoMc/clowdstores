import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Models/order.dart';
import '../helpers/change_notifiiers.dart';

class OrderProvider extends ChangeNotifier {
  final uuid = const Uuid();
  late String _productName;
  late String _productPrice;
  late String _productPhotoUrl;
  late String _storeId;
  late String _orderId;
  late String _userNumber;
  late String _userName;
  late String _productId;
  late String _productType;

  ///? getters

  String get productName => _productName;
  String get productPrice => _productPrice;
  String get productPhotoUrl => _productPhotoUrl;
  String get storeId => _storeId;
  String get orderId => _orderId;
  String get userNumber => _userNumber;
  String get userName => _userName;
  String get productId => _productId;
  String get productType => _productType;

  ///?Setters

  chnageProductName(String value) {
    _productName = (value);
  }

  chnageProductPrice(String value) {
    _productPrice = (value);
  }

  chnageProductproductPhotoUrl(String value) {
    _productPhotoUrl = (value);
  }

  chnagestoreId(String value) {
    _storeId = (value);
  }

  chnageUserName(String? value) {
    _userName = (value)!;
  }

  chnageUserNumber(String value) {
    _userNumber = (value);
  }

  chnageProductId(String value) {
    _productId = (value);
  }

  chnageProductType(String value) {
    _productType = (value);
  }

  saveOrder(String storeId) {
    var saveorder = OrderModel(
      productPhotoUrl: productPhotoUrl,
      productName: productName,
      productPrice: productPrice,
      orderId: uuid.v4(),
      storeId: storeId,
      userNumber: userNumber,
      userName: userName,
      productId: productId,
      productType: productType,
    );
    firestoreService.storeOrders(saveorder, storeId);
  }
}

///? CartProvider

class CartProvider extends ChangeNotifier {
  final uuid = const Uuid();
  late String _productName;
  late double _productPrice;
  late String _productPhotoUrl;
  late String _storeId;
  late String _cartId;
  // late String _storeNumber;
  late String _storeName;
  late String _productId;
  late String _productType;

  ///? getters

  String get productName => _productName;
  double get productPrice => _productPrice;
  String get productPhotoUrl => _productPhotoUrl;
  String get storeId => _storeId;
  String get cartId => _cartId;
  // String get storeNumber => _storeNumber;
  String get storeName => _storeName;
  String get productId => _productId;
  String get productType => _productType;

  ///?Setters

  chnageProductName(String value) {
    _productName = (value);
  }

  chnageProductPrice(double value) {
    _productPrice = (value);
  }

  chnageProductproductPhotoUrl(String value) {
    _productPhotoUrl = (value);
  }

  chnagestoreId(String value) {
    _storeId = (value);
  }

  chnageUserName(String? value) {
    _storeName = (value)!;
  }

  chnageStoreNumber(String value) {
    // _storeNumber = (value);
  }

  chnageProductId(String value) {
    _productId = (value);
  }

  chnageProductType(String value) {
    _productType = (value);
  }

  saveCart() {
    var saveCartr = CartModel(
      productPhotoUrl: productPhotoUrl,
      productName: productName,
      productPrice: productPrice,
      storeId: storeId,
      cartId: uuid.v4(),
      // storeNumber: storeNumber,
      storeName: storeName,
      productId: productId,
      productType: productType,
    );
    firestoreService.userCart(saveCartr);
  }
}
