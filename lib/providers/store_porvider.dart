import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';

import '../Data/fire_store_streams.dart';
import '../Models/store.dart';
import '../helpers/change_notifiiers.dart';

class StoreProvider extends ChangeNotifier {
  late double progress = 0.0;
  late String _businessName;
  late String _city;
  late String _categories;
  late String _businessPhone;
  late String _webAddress = "";
  late String _businesaddress;
  late String _businessEmail = "";
  late String _workingHours;
  late String? _photoUrl;
  late Timestamp onCreated;
  late double _longitude;
  late double _latitude;
  late double? _liveLongitude = 31.2740701;
  late double? _liveLatitude = 29.9712422;

//geters

  String get businessName => _businessName;
  String get city => _city;
  String get categories => _categories;
  String get businessPhone => _businessPhone;
  String get webAddress => _webAddress;
  String get businesaddress => _businesaddress;
  String get businessEmail => _businessEmail;
  String get workingHours => _workingHours;
  String? get photoUrl => _photoUrl;
  double get longitude => _longitude;
  double get ltitude => _latitude;
  double? get liveLongitude => _liveLongitude;
  double? get liveLtitude => _liveLatitude;
  // double? get progress => _progress;

  ///**setters
  changeBusinessName(String value) {
    _businessName = value;
    notifyListeners();
  }

  changeCity(String value) {
    _city = value;
    notifyListeners();
  }

  cahangeBusinessAdress(String value) {
    _businesaddress = value;
    notifyListeners();
  }

  changeCategorise(String value) {
    _categories = value;
    notifyListeners();
  }

  changeBusinessPhone(String value) {
    _businessPhone = (value);
    notifyListeners();
  }

  changeWebAddress(String value) {
    _webAddress = value;
    notifyListeners();
  }

  changeBusinessEmail(String value) {
    _businessEmail = value;
    notifyListeners();
  }

  changeWorkingHours(String value) {
    _workingHours = (value);
    notifyListeners();
  }

  upoadPhoto(String value) {
    _photoUrl = (value);
    notifyListeners();
  }

  getLocationPro() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    dynamic liveLocationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }

    locationData = await location.getLocation();
    liveLocationData = location.onLocationChanged.listen((event) {
      _liveLatitude = event.latitude!;
      _liveLongitude = event.longitude!;
    });

    _longitude = locationData.longitude!;
    _latitude = locationData.latitude!;
    notifyListeners();
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink;
  }

  buildDynamicLinks(
      String title, String image, String docId, String routeName) async {
    String url = "http://clowd.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/?link=https://clowdstores.com/$routeName/$docId'),
      androidParameters: const AndroidParameters(
        packageName: "com.dotcoder.dynamic_link_example",
        minimumVersion: 0,
      ),
      // iosParameters: IosParameters(
      //   bundleId: "Bundle-ID",
      //   minimumVersion: '0',
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: '', imageUrl: Uri.parse(image), title: title),
    );
    FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final ShortDynamicLink dynamicUrl = await link.buildShortLink(parameters);

    //String? desc = '${dynamicUrl.shortUrl.toString()}';
  }
  // laodStores(StoreModel storeModel) {
  //   _businessName = storeModel.businessName;
  //   _city = storeModel.city;
  //   _categories = storeModel.categories;
  //   _businessPhone = storeModel.businessPhone;
  //   _webAddress = storeModel.webAddress;
  //   _businesaddress = storeModel.businesaddress;
  //   _businessEmail = storeModel.businessEmail;
  //   _workingHours = storeModel.workingHours;
  //   _photoUrl = storeModel.photoUrl;
  //   notifyListeners();
  // }

  // changeStoreToken() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   String? token = await messaging.getToken();
  //   _storeToken = token!;
  // }

  saveUserBusiness() {
    var newStore = StoreModel(
      userId: uid,
      businessName: businessName,
      city: city,
      categories: categories,
      businessPhone: businessPhone,
      webAddress: webAddress,
      businesaddress: businesaddress,
      businessEmail: businessEmail,
      workingHours: workingHours,
      longitude: _longitude,
      latitude: _latitude,
      photoUrl: photoUrl!,
      onCreated: Timestamp.now(),
    );

    firestoreService.saveStore(newStore);
  }
}
