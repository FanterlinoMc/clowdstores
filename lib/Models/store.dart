import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  final String? userId;
  final String businessName;
  final String city;
  final String categories;
  final String businessPhone;
  final String webAddress;
  final String businesaddress;
  final String businessEmail;
  final String workingHours;
  final String photoUrl;
  final Timestamp onCreated;
  final double latitude;
  final double longitude;

  // final String storeToken;

  StoreModel({
    required this.userId,
    required this.businessName,
    required this.city,
    required this.categories,
    required this.businessPhone,
    required this.webAddress,
    required this.businesaddress,
    required this.businessEmail,
    required this.workingHours,
    required this.photoUrl,
    required this.onCreated,
    required this.longitude,
    required this.latitude,
    // required this.storeToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'businessName': businessName,
      'city': city,
      'categories': categories,
      'businessPhone': businessPhone,
      'webAddress': webAddress,
      'businesaddress': businesaddress,
      'businessEmail': businessEmail,
      'workingHours': workingHours,
      'photoUrl': photoUrl,
      'onCreated': onCreated,
      'longitude': longitude,
      'latitude': latitude,
      // // 'storeToken': storeToken,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      userId: map['userId'],
      businessName: map['businessName'],
      city: map['city'],
      categories: map['categories'],
      businessPhone: map['businessPhone'],
      webAddress: map['webAddress'],
      businesaddress: map['businesaddress'],
      businessEmail: map['businessEmail'],
      workingHours: map['workingHours'],
      photoUrl: map['photoUrl'],
      onCreated: map['onCreated'],
      longitude: map['longitude'],
      latitude: map['altitude,'],
      // // storeToken: map['storeToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source));
}
