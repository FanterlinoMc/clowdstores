import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Data/fire_store_streams.dart';
import '../Models/product.dart';
import '../helpers/change_notifiiers.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance.currentUser;
  final uuid = const Uuid();

  late String _name;
  late String _city;
  late String _store;

  late String _description;
  late double _price;
  dynamic _photoUrl;
  late String _storephotoUrl;
  late String _productType;

  late String _storeId;
  late String _productId;

  late double _quantity;
  late double _latitude;
  late double _longitude;
  late Timestamp _onCreated;
  late String? _productType0;
  late String? _productType1;
  late String? _productType2;
//geters

  String get name => _name;
  String get city => _city;
  String get storeName => _store;

  String get description => _description;
  double get price => _price;
  String get productType => _productType;

  dynamic get photoUrl => _photoUrl;
  String get storephotoUrl => _storephotoUrl;
  String get storeId => _storeId;
  String get productId => _productId;

  double get quantity => _quantity;
  double get latitude => _latitude;
  double get longitude => _longitude;
  Timestamp get onCraeted => _onCreated;

  String? get productType0 => _productType0;
  String? get productType1 => _productType1;
  String? get productType2 => _productType2;

//Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changeCity(String value) {
    _city = value;
    notifyListeners();
  }

  changeStoreName(String value) {
    _store = value;
    notifyListeners();
  }

  changeStorePhotoUrl(String value) {
    _storephotoUrl = value;
    notifyListeners();
  }

  changeDescription(String value) {
    _description = (value);
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  changeQuantity(String value) {
    _quantity = double.parse(value);
    notifyListeners();
  }

  changeLat(double value) {
    _latitude = (value);
    notifyListeners();
  }

  changeLon(double value) {
    _longitude = (value);
    notifyListeners();
  }

  changeProductType(String value) {
    _productType = (value);

    notifyListeners();
  }

  changeProductType0(String value) {
    _productType0 = (value);

    notifyListeners();
  }

  changeProductType1(String value) {
    _productType1 = (value);

    notifyListeners();
  }

  changeProductType2(String value) {
    _productType2 = (value);

    notifyListeners();
  }

  uploadPhoto(String value) {
    _photoUrl = (value);

    notifyListeners();
  }

  // changePhoto({UploadTask? uploadingTask, String? value}) async {
  //   UploadTask uploadTask;

  //   final Uint8List? image;

  //   //  late String? imageString;
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(allowMultiple: false, type: FileType.image);
  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     String fileName = result.names.toString();

  //     // final metadata = SettableMetadata(contentType: 'image/jpeg');

  //     Reference ref =
  //         FirebaseStorage.instance.ref().child("prducts / $fileName"); //ge

  //     if (kIsWeb) {
  //       image = file.bytes;
  //       uploadTask = ref.putData(image!);
  //       _photoUrl =
  //           await ref.getDownloadURL().whenComplete(() => _photoUrl = "");
  //     } else {
  //       final croppedFile = await ImageCropper().cropImage(
  //           sourcePath: file.path!,
  //           compressFormat: ImageCompressFormat.jpg,
  //           compressQuality: 80,
  //           uiSettings: [
  //             AndroidUiSettings(
  //                 toolbarTitle: 'Cropper',
  //                 toolbarColor: appBarColor,
  //                 toolbarWidgetColor: Colors.white,
  //                 initAspectRatio: CropAspectRatioPreset.original,
  //                 lockAspectRatio: false),
  //           ]);
  //       uploadTask = ref.putFile(
  //         io.File(croppedFile!.path),
  //       );
  //       _photoUrl =
  //           await ref.getDownloadURL().whenComplete(() => _photoUrl = "");
  //       //  }
  //       StreamBuilder<TaskSnapshot>(
  //         stream: uploadingTask?.snapshotEvents,
  //         builder: (context, snapshot) {
  //           if (snapshot.hasData) {
  //             final snap = snapshot.data!;
  //             final progress = snap.bytesTransferred / snap.totalBytes;
  //             final percentage = (progress * 100).toStringAsFixed(2);

  //             return Dialog(
  //               child: Text("Uploading.. $percentage"),
  //             );
  //           } else {
  //             return Container();
  //           }
  //         },
  //       );
  //     }
  //   }
  //   return _photoUrl;
  // }

  productCheck() {
    if (_name.isEmpty &&
        _description.isEmpty &&
        _price.isNaN &&
        _photoUrl.isEmpty) {
      ClowdSliverAppBar()
          .showSnackBar(message: "Please enter complete product details");
    } else {
      ClowdSliverAppBar().showSnackBar(message: "Product added successfully");
    }
  }

  saveProduct() {
    try {
      var newProduct = ProductModel(
        city: city,
        latitude: latitude,
        longitude: longitude,
        name: name,
        storeName: storeName,
        storephotoUrl: storephotoUrl,
        description: description,
        storeId: auth!.uid,
        productId: uuid.v4(),
        price: price,
        quantity: quantity,
        productType: productType,
        photoUrl: photoUrl ?? "",
        onCreated: Timestamp.now(),
      );
      WriteCache.setString(key: "city", value: city);
      WriteCache.setDouble(key: "latitude", value: latitude);
      WriteCache.setDouble(key: "longitude", value: longitude);
      WriteCache.setString(key: "storeName", value: storeName);

      WriteCache.setString(key: "storephotoUrl", value: storephotoUrl);
      firestoreService.saveProduct(newProduct);
    } catch (e) {
      throw Exption(
        erorr: e.toString(),
      );
      //  print(e);
    }

    // .whenComplete(() =>
    //     ClowdSliverAppBar()
    //         .showSnackBar(message: "Product added successfully"));
  }

  createProductType() {
    var newType = ProductModelT(
      productType0: _productType0,
      productType1: _productType1,
      productType2: _productType2,
      storeId: uid,
      onCreated: Timestamp.now(),
    );
    firestoreService.createProduct(newType);
  }

  updateProduct(
    String productId,
  ) {
    var newProduct = ProductModel(
      city: city,
      latitude: latitude,
      longitude: longitude,
      name: name,
      //   storeNumber: storeNumber,
      storeName: storeName,
      storephotoUrl: storephotoUrl,
      description: description,
      storeId: auth!.uid,
      productId: productId,

      price: price,
      quantity: quantity,
      productType: productType,
      photoUrl: photoUrl!,
      onCreated: Timestamp.now(),
    );

    firestoreService.updateProduct(productModel: newProduct, id: productId);
  }
}
