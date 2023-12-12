import 'dart:convert';

class DeliveryModel {
  ///?Store + Product
  final String name;
  final String city;
  final String store;
  final String description;
  final double price;
  final String photoUrl;
  final String storephotoUrl;
  final String productType;
  final String storeId;
  final String productId;
  final double latitude;
  final double longitude;

  ///?User
  final String userName;
  final String userPhone;
  final String userAddrees;
  final double userLat;
  final double userLgn;

  ///?Order
  final bool pickUp;
  final bool dropOff;
  final String orderStatus;
  final String orderId;
  DeliveryModel({
    required this.name,
    required this.city,
    required this.store,
    required this.description,
    required this.price,
    required this.photoUrl,
    required this.storephotoUrl,
    required this.productType,
    required this.storeId,
    required this.productId,
    required this.latitude,
    required this.longitude,
    required this.userName,
    required this.userPhone,
    required this.userAddrees,
    required this.userLat,
    required this.userLgn,
    required this.pickUp,
    required this.dropOff,
    required this.orderStatus,
    required this.orderId,
  });
  // late String orderId

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'store': store,
      'description': description,
      'price': price,
      'photoUrl': photoUrl,
      'storephotoUrl': storephotoUrl,
      'productType': productType,
      'storeId': storeId,
      'productId': productId,
      'latitude': latitude,
      'longitude': longitude,
      'userName': userName,
      'userPhone': userPhone,
      'userAdrees': userAddrees,
      'userLat': userLat,
      'userLgn': userLgn,
      'pickUp': pickUp,
      'dropOff': dropOff,
      'orderStatus': orderStatus,
      'orderId': orderId,
    };
  }

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    return DeliveryModel(
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      store: map['store'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      photoUrl: map['photoUrl'] ?? '',
      storephotoUrl: map['storephotoUrl'] ?? '',
      productType: map['productType'] ?? '',
      storeId: map['storeId'] ?? '',
      productId: map['productId'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      userName: map['userName'] ?? '',
      userPhone: map['userPhone'] ?? '',
      userAddrees: map['userAddrees'] ?? '',
      userLat: map['userLat']?.toDouble() ?? 0.0,
      userLgn: map['userLgn']?.toDouble() ?? 0.0,
      pickUp: map['pickUp'] ?? false,
      dropOff: map['dropOff'] ?? false,
      orderStatus: map['orderStatus'] ?? '',
      orderId: map['orderId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryModel.fromJson(String source) =>
      DeliveryModel.fromMap(json.decode(source));
}
