import 'package:clowdstores/providers/validator_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Data/firestore_service.dart';
import '../Data/sign_In_google.dart';
import '../providers/deep_link.dart';
import '../providers/delivery_provider.dart';
import '../providers/fcm.dart';
import '../providers/messages_pro.dart';
import '../providers/order.dart';
import '../providers/product_provider.dart';
import '../providers/review_provider.dart';
import '../providers/cacheProvider.dart';
import '../providers/shoppingfeed_pro.dart';
import '../providers/store_porvider.dart';
import '../providers/user_provider.dart';

final firestoreService = FirestoreService();

final sendMessageNotifer =
    ChangeNotifierProvider<MessagesPro>((ref) => MessagesPro());

//final fcmNotifer = ChangeNotifierProvider<FcmProvider>((ref) => FcmProvider());

final productPro =
    ChangeNotifierProvider<ProductProvider>((ref) => ProductProvider());

final isUserNotifer = ChangeNotifierProvider<UserPro>((ref) => UserPro());
final isChangeUserNotifer =
    ChangeNotifierProvider<ChangeUserPro>((ref) => ChangeUserPro());

// final orderNotifer =
    // ChangeNotifierProvider<OrderProvider>((ref) => OrderProvider());

final cartNotifer =
    ChangeNotifierProvider<CartProvider>((ref) => CartProvider());

final storeNotifer =
    ChangeNotifierProvider<StoreProvider>((ref) => StoreProvider());

final addReview =
    ChangeNotifierProvider<ReviewProvider>((ref) => ReviewProvider());
final cacheState =
    ChangeNotifierProvider<CacheProvider>((ref) => CacheProvider());
final validatorProvider =
    ChangeNotifierProvider<ValidatorProvider>((ref) => ValidatorProvider());
final clowdLink = ChangeNotifierProvider<ClowdLink>((ref) => ClowdLink());
final signIn =
    ChangeNotifierProvider<SignInWithGoogle>((ref) => SignInWithGoogle());
final postNotifire = ChangeNotifierProvider<ShoppingFeedProvider>(
    (ref) => ShoppingFeedProvider());
final getDellivery = ChangeNotifierProvider<Delivery>((ref) => Delivery());
