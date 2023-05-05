import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String name;
  final String city;
  final String storeName;
  // final String storeNumber;
  final String description;
  final String storeId;
  final String productId;

  final double price;
  final double quantity;
  // final bool showType;
  final String photoUrl;
  final String storephotoUrl;
  final String productType;
  final double latitude;
  final double longitude;
  final Timestamp onCreated;
  ProductModel({
    required this.name,
    required this.city,
    required this.storeName,
    // required this.storeNumber,
    required this.description,
    required this.storeId,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.photoUrl,
    required this.storephotoUrl,
    required this.productType,
    required this.latitude,
    required this.longitude,
    required this.onCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'storeName': storeName,
      'storephotoUrl': storephotoUrl,
      'description': description,
      'storeId': storeId,
      'productId': productId,
      'price': price,
      'quantity': quantity,
      'productType': productType,
      'photoUrl': photoUrl,
      'onCreated': onCreated,
      "lattitude": latitude,
      "longitude": longitude,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      storeName: map['storeName'] ?? '',
      storephotoUrl: map['storephotoUrl'] ?? '',
      description: map['description'] ?? '',
      storeId: map['storeId'] ?? '',
      productId: map['productId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      productType: map['productType'] ?? " no Info",
      photoUrl: map['photoUrl'] ?? "",
      onCreated: map['onCreated'] ?? "",
      latitude: map["latitude"] ?? "",
      longitude: map["longitude"] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}

class ProductModelT {
  late String? productType0;
  late String? productType1;
  late String? productType2;
  late String? storeId;
  final bool? showType;
  final Timestamp onCreated;
  ProductModelT({
    this.showType,
    this.productType0,
    this.productType1,
    this.productType2,
    this.storeId,
    required this.onCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'productType0': productType0 ?? "",
      'productType1': productType1 ?? "",
      'productType2': productType2,
      'storeId': storeId,
      'onCreated': onCreated,
    };
  }

  factory ProductModelT.fromMap(Map<String, dynamic> map) {
    return ProductModelT(
      onCreated: map['onCreated'] ?? "",
      storeId: map['storeId'] ?? "",
      productType0: map["productType0"] ?? '',
      productType1: map["productType1"] ?? '',
      productType2: map["productType2"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModelT.fromJson(String source) =>
      ProductModelT.fromMap(json.decode(source));
}
