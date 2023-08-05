import 'package:cache_manager/cache_manager.dart';
import "package:cloud_firestore/cloud_firestore.dart";
// import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final String uid = auth.currentUser!.uid;
final String? fUserP = auth.currentUser!.photoURL;
final String? fUserN = auth.currentUser!.displayName;
final String? fUserE = auth.currentUser!.email;
final String? fUserPhone = auth.currentUser!.phoneNumber;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

const appBarColor = //Colors.blueGrey;
    Color(0xFF082032);
const size = MediaQuery;
const subTextStyle = TextStyle(fontSize: 14, color: Colors.black);
const textStyle = TextStyle(
  fontSize: 12,
  fontFamily: "Roboto",
);
const rowStyle =
    TextStyle(fontSize: 15, fontFamily: "Roboto", color: Colors.white);

class CloudStreams {
  //**User Streams */
  Stream<QuerySnapshot<Map<String, dynamic>>> getStores() {
    return FirebaseFirestore.instance.collection('Stores').snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getChangeUser() {
    return FirebaseFirestore.instance
        .collection('ChangeUser')
        .doc(uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPost() {
    return FirebaseFirestore.instance.collectionGroup('Post').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStore() async* {
    yield* FirebaseFirestore.instance
        .collection('Stores')
        .where("userId", isEqualTo: uid)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> productRow() async {
    return FirebaseFirestore.instance
        .collection("product")
        .where("storeId", isEqualTo: uid)

        //   .orderBy("onCreated", descending: true)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductSuggtion() async* {
    yield* FirebaseFirestore.instance
        .collection("product")

        //   .orderBy("onCreated", descending: true)
        .snapshots();
  }

//**View Streams */
  Stream<QuerySnapshot<Map<String, dynamic>>> getStoreView() async* {
    String? randomString = await ReadCache.getString(key: "randomString");
    yield* FirebaseFirestore.instance
        .collection('Stores')
        .where("userId", isEqualTo: randomString)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> productRowView() async {
    String? randomString = await ReadCache.getString(key: "randomString");
    return FirebaseFirestore.instance
        .collection("product")
        .where("storeId", isEqualTo: randomString)

        //   .orderBy("onCreated", descending: true)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRandomProduct() async* {
    var proType = await ReadCache.getString(key: "proType");
    // String pro = "Mobile";
    yield* FirebaseFirestore.instance
        .collectionGroup("product")
        // .doc()
        // .collection("product")
        .where("productType", isEqualTo: proType ?? "Phones")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductDetail() async* {
    String? collectionId = await ReadCache.getString(key: "collectionId");
    String? docId = await ReadCache.getString(key: "docId");
    yield* FirebaseFirestore.instance
        .collection("product")
        .doc(collectionId)
        .collection("product")
        .where("productId", isEqualTo: docId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategroise() async* {
    String? randomString = await ReadCache.getString(key: "randomString");

    yield* FirebaseFirestore.instance
        .collection('Stores')
        .where("categories", isEqualTo: randomString)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> storeMap() async* {
    String? randomMap = await ReadCache.getString(key: "randomMap");
    yield* FirebaseFirestore.instance
        .collection('Stores')
        .where("categories", isEqualTo: randomMap)
        //  .where("businessName", isEqualTo: randomMap)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> storeMapCat() async* {
    String? randomMap = await ReadCache.getString(key: "randomMap");
    yield* FirebaseFirestore.instance
        .collection('Stores')
        .where("categories", isEqualTo: randomMap)
        //  .where("businessName", isEqualTo: randomMap)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUsers() {
    return FirebaseFirestore.instance.collection('User').doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrders() async* {
    yield* FirebaseFirestore.instance
        .collection("Order")
        .doc(uid)
        .collection("Order")
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProduct() async {
    String? routecId = await ReadCache.getString(key: "routeId");
    String? subRouteId = await ReadCache.getString(key: "subRouteId");
    return FirebaseFirestore.instance
        .collection("product")
        .doc(routecId)
        .collection("product")
        //   .orderBy("onCreated", descending: true)
        .where("productType", isEqualTo: subRouteId)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCart() {
    return FirebaseFirestore.instance
        .collection('Cart')
        .doc(uid)
        .collection("Cart")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> messageList() {
    return _firestore
        .collection("ChatList")
        .doc(uid)
        .collection("Messages")
        .snapshots();
  }

  // Stream<DocumentSnapshot<Map<String, dynamic>>> messageLis() {
  //   return _firestore
  //       .collection("ChatList")
  //       .doc(uid)
  //       .collection("Messages")
  //       .doc()
  //       .snapshots();
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatRoom() async* {
    String? id = await ReadCache.getString(key: "roomId");
    yield* _firestore
        .collection("ChatRoom")
        .doc(id)
        .collection("Messages")
        .doc(id)
        .collection("Messages")
        .orderBy("newMassage", descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> searchProduct(
      String productName) {
    return FirebaseFirestore.instance
        .collectionGroup("product")
        //.where("name", isGreaterThanOrEqualTo: productName)
        .where("name", isLessThanOrEqualTo: productName)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> reviewStream() async* {
    String? randomString = await ReadCache.getString(key: "randomString");
    yield* FirebaseFirestore.instance
        .collection('Reviews')
        .doc(randomString)
        .collection("Reviews")
        .snapshots();
  }
}
