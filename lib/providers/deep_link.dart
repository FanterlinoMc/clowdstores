import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../ui/pages/StoerViews/peowfile_view.dart';
import '../ui/store/products/detail_page.dart';

class ClowdLink with ChangeNotifier {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  late String? _userId = "";
  late String? _productId = "";
  late dynamic _image;
  late String? _description = "";
  late String? _title = "";
  late String? _price = "";

//geters

  String? get userId => _userId;
  String? get productId => _productId;
  String? get image => _image;
  String? get description => _description;
  String? get title => _title;
  String? get price => _price;

  // ///**setters
  changeUserId(String? value) {
    _userId = value;
    notifyListeners();
  }

  changeProductId(String? value) {
    _productId = value;
    notifyListeners();
  }

  changeImage(dynamic value) {
    _image = (value);
    notifyListeners();
  }

  changeDescription(String? value) {
    _description = value;
    notifyListeners();
  }

  changeTitle(String? value) {
    _title = value;
    notifyListeners();
  }

  changePrice(String? value) {
    _price = value;
    notifyListeners();
  }

  Future<String> createStoreLink() async {
    //   final String url = 'https://clowdstores.page.link?userId= $_userId';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://clowdstore.page.link',
      link: Uri.parse('https://clowdstores.com?userId=$_userId'),
      androidParameters: AndroidParameters(
        packageName: 'com.believers.clowdstores',
        fallbackUrl: Uri.parse("https://clowdstores.com"),
        minimumVersion: 0,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          imageUrl: Uri.parse(_image),
          description: _description,
          title: _title),
      iosParameters: const IOSParameters(
        bundleId: 'com.believers.clowdstores',
        minimumVersion: '0',
      ),
    );
    final userLink = await dynamicLinks.buildShortLink(parameters);
    print(userLink.shortUrl);
    final link = userLink.shortUrl;
    await Share.share("$link");
    return userLink.shortUrl.toString();
  }

  Future<String> createProductLink() async {
    //   final String url = 'https://clowdstores.page.link?userId= $_userId';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://clowdstore.page.link',
      link: Uri.parse(
          'https://clowdstores.com?docsId=$_userId&ProductId=$_productId'),
      androidParameters: AndroidParameters(
        packageName: 'com.believers.clowdstores',
        fallbackUrl: Uri.parse("https://clowdstores.com"),
        minimumVersion: 0,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          imageUrl: Uri.parse(_image),
          description: _description,
          title: _title),
      iosParameters: const IOSParameters(
        bundleId: 'com.believers.clowdstores',
        minimumVersion: '0',
      ),
    );
    final userLink = await dynamicLinks.buildShortLink(parameters);
    print(userLink.shortUrl);
    final link = userLink.shortUrl;
    await Share.share("$link");
    return userLink.shortUrl.toString();
  }

  void initalDynamic(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((event) async {
//  final Uri userUri = userLink.link;
      Map result = event.link.queryParameters;

      if (result.containsKey("userId")) {
        String userId = result["userId"];
        // context.push("/Profile");
        WriteCache.setString(key: "randomString", value: userId);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileView()),
        );
      } else if (result.containsKey("ProductId")) {
        String userId = result["docsId"];
        String productId = result["ProductId"];
        WriteCache.setString(key: "collectionId", value: userId);
        WriteCache.setString(key: "docId", value: productId);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetaliPage()),
        );
      }
    });
  }
}
