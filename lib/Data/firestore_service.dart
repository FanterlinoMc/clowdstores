import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:clowdstores/Models/user.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../Models/messages_model.dart';
import '../Models/order.dart';
import '../Models/product.dart';
import '../Models/review_model.dart';
import '../Models/sfeedModel.dart';
import '../Models/store.dart';
import '../Widgets/coming_soon.dart';
import 'fire_store_streams.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future storeOrders(OrderModel orderModel, String storeId) async {
    var id = orderModel.orderId;
    return await _db
        .collection("Order")
        .doc(storeId)
        .collection("Order")
        .doc(id)
        .set(orderModel.toMap());
  }

  Future savepost(ShoppingFeedModel savePost) async {
    // var id = orderModel.orderId;
    return await _db
        .collection("Post")
        .doc(uid)
        .collection("Post")
        .doc()
        .set(savePost.toMap());
  }

  Future userCart(CartModel cartModel) async {
    var id = cartModel.cartId;
    return await _db
        .collection("Cart")
        .doc(uid)
        .collection("Cart")
        .doc(id)
        .set(cartModel.toMap());
  }

  ///*Product Collection
  ///
  ///
  createProduct(ProductModelT productModelT) async {
    return await _db.collection("product").doc(uid).set(productModelT.toMap());
  }

  Future saveProduct(ProductModel productModel) async {
    var id = productModel.productId;
    try {
      return await _db
          .collection("product")
          .doc(uid)
          .collection("product")
          .doc(id)
          .set(productModel.toMap())
          .whenComplete(
              () => const Exption(erorr: "Product added successfully"));
    } catch (e) {
      // print(e);
    }
  }

  updatProduct(ProductModelT productModelT) async {
    return await _db
        .collection("product")
        .doc(uid)
        .update(productModelT.toMap());
  }

  Future updateProduct({ProductModel? productModel, String? id}) async {
    return await _db
        .collection("product")
        .doc(uid)
        .collection("product")
        .doc(id)
        .update(productModel!.toMap());

    // .set(productModel!.toMap());
  }

  ///* Review Collection
  ///
  ///
  addReview(ReviewModel reviewModel, String storeId) async {
    return await _db
        .collection("Reviews")
        .doc(storeId)
        .collection("Reviews")
        .add(reviewModel.toMap());
  }

  ///* Messages Collecion
  ///
  ///

  Future chatList(
      ChatRoomModel chatRoomModel, String? senderId, String? roomId) async {
    var id = chatRoomModel.roomId;
    return _db
        .collection("ChatList")
        .doc(senderId)
        .collection("Messages")
        .doc(id)
        .set(chatRoomModel.toMap());
  }

  Future chatListUid(
    ChatRoomModel chatRoomModel,
    String? roomId,
  ) async {
    var id = chatRoomModel.roomId;
    return _db
        .collection("ChatList")
        .doc(uid)
        .collection("Messages")
        .doc(id)
        .set(chatRoomModel.toMap());
  }

  ///? update Chat Room
  Future updateRoom(UpdateMessagesModel? chatRoomModel, String? senderId,
      String? roomId) async {
    return _db
        .collection("ChatList")
        .doc(senderId)
        .collection("Messages")
        .doc(roomId)
        .update(chatRoomModel!.toMapUpdate());
  }

  Future updateRoomUid(
      UpdateMessagesModel chatRoomModel, String? roomId, String? userId) async {
    return _db
        .collection("ChatList")
        .doc(userId)
        .collection("Messages")
        .doc(roomId)
        .update(chatRoomModel.toMapUpdate());
  }

  Future chatRoom(
      {required MessagesModel messagesModel, String? roomId}) async {
    // var messages = messagesModel.messagesId;
    CollectionReference chatRoom = FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId)
        .collection("Messages");

    return chatRoom
        .doc(roomId)
        .collection("Messages")
        .add(messagesModel.toMap());
  }

//* Users Collection

  Future saveUser(UserModel userModel) async {
    //   FirebaseAuth auth = FirebaseAuth.instance;
    return _db.collection("User").doc(uid).set(userModel.toMap());
  }

  Future changeUser(ChangeUseModel userModel) async {
    //   FirebaseAuth auth = FirebaseAuth.instance;
    return _db.collection("ChangeUser").doc(uid).set(userModel.toMap());
  }

  Stream<QuerySnapshot> getUser(String userName, String cate) {
    return FirebaseFirestore.instance
        .collection("User")
        .where("Name", isLessThanOrEqualTo: userName)
        .snapshots();
  }

  ///? Stores Collection

  Future saveStore(StoreModel userStore) async {
    return _db.collection("Stores").doc(uid).set(userStore.toMap());
  }

  static Future<QuerySnapshot> searchUsers(String name) async {
    Future<QuerySnapshot> users = FirebaseFirestore.instance
        .collection("Stores")
        .where("businessName", isGreaterThanOrEqualTo: name)
        .get();

    return users;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> reviewStream(String? userId) {
    return FirebaseFirestore.instance
        .collection('Reviews')
        .doc(userId)
        .collection("Reviews")
        .snapshots();
  }
}
