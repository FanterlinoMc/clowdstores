import 'dart:convert';

class OrderModel {
  final String productName;
  final String productPrice;
  final String productPhotoUrl;
  final String storeId;
  final String orderId;
  final String userNumber;
  final String userName;
  final String productId;
  final String productType;

  OrderModel({
    required this.productName,
    required this.productPrice,
    required this.productPhotoUrl,
    required this.storeId,
    required this.orderId,
    required this.userNumber,
    required this.userName,
    required this.productId,
    required this.productType,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'productPhotoUrl': productPhotoUrl,
      'storeId': storeId,
      'orderId': orderId,
      'userNumber': userNumber,
      'userName': userName,
      "productId": productId,
      "productType": productType,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] ?? '',
      productPhotoUrl: map['productPhotoUrl'] ?? '',
      storeId: map['storeId'] ?? '',
      orderId: map['orderId'] ?? '',
      userNumber: map['userNumber'] ?? '',
      userName: map['userName'] ?? '',
      productId: map["productId"] ?? "",
      productType: map["productType"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}

///? CartModel
class CartModel {
  final String productName;
  final String productPrice;
  final String productPhotoUrl;
  final String storeId;
  final String cartId;
  // final String storeNumber;
  final String storeName;
  final String productId;
  final String productType;

  CartModel({
    required this.productName,
    required this.productPrice,
    required this.productPhotoUrl,
    required this.storeId,
    required this.cartId,
    // required this.storeNumber,
    required this.storeName,
    required this.productId,
    required this.productType,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'productPhotoUrl': productPhotoUrl,
      'storeId': storeId,
      'cartId': cartId,
      // // 'storeNumber': storeNumber,
      'storeName': storeName,
      "productId": productId,
      "productType": productType,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] ?? '',
      productPhotoUrl: map['productPhotoUrl'] ?? '',
      storeId: map['storeId'] ?? '',
      cartId: map['cartId'] ?? '',
      // // storeNumber: map['storeNumber'] ?? '',
      storeName: map['storeName'] ?? '',
      productId: map["productId"] ?? "",
      productType: map["productType"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));
}
