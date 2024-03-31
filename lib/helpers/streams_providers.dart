import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/providers/store_porvider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Data/fire_store_streams.dart';
import '../ui/pages/profile/profile_page.dart';

final getStreams = Provider<CloudStreams>((ref) => CloudStreams());
final getStrea = Provider<Profile>((ref) => const Profile());
//final getProductRow = Provider<ProductRow>((ref) =>  ProductRow());

final storeProvider = Provider<StoreProvider>((ref) => StoreProvider());

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

//**User Streams */

final authStateStraem = StreamProvider((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final getStores = StreamProvider.autoDispose((ref) {
  final streams = ref.watch(getStreams);
  return streams.getStores();
});
final getPost = StreamProvider.autoDispose((ref) {
  final streams = ref.watch(getStreams);
  return streams.getPost();
});
final getUserPost = StreamProvider.autoDispose((ref) {
  final streams = ref.watch(getStreams);
  return streams.getUserPost();
});
final getStore = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getStore();
});
// final storeMapCat = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  // final streams = ref.watch(getStreams);
  // return streams.storeMapCat();
// });
//
final getUsers =
    StreamProvider.autoDispose<DocumentSnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getUsers();
});

final getchangeUser =
    StreamProvider.autoDispose<DocumentSnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getChangeUser();
});

final productRow =
    FutureProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.productRow();
});
final getProductSuggtion =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getProductSuggtion();
});

//**View Streams */
final getStoreView = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getStoreView();
});
final storeMap =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.storeMap();
});

final productRowView =
    FutureProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.productRowView();
});

final getOrders =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getOrders();
});
final getCategroise =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getCategroise();
});

final messageList =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.messageList();
});
final getCart =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getCart();
});
// final messageLis =
//     StreamProvider.autoDispose<DocumentSnapshot<Map<String, dynamic>>>((ref) {
//   final streams = ref.watch(getStreams);
//   return streams.messageLis();
// });

final getProductDetail =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getProductDetail();
});
final getRandomProduct =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getRandomProduct();
});
final getProduct =
    FutureProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getProduct();
});
final getMessages =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.chatRoom();
});
final reviewstream =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.reviewStream();
});
final getCheckOut =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final streams = ref.watch(getStreams);
  return streams.getCheckOut();
});
