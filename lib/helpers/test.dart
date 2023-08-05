import 'dart:io';

import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:clowdstores/Widgets/button.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class ProductUplaodPage extends StatefulWidget {
  const ProductUplaodPage({Key? key}) : super(key: key);

  @override
  _ProductUplaodPageState createState() => _ProductUplaodPageState();
}

class _ProductUplaodPageState extends State<ProductUplaodPage> {
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final product = ref.read(productPro);
      return Column(
        children: [
          ProgressBar(
            //   duration: const Duration(seconds: 3),
            value: progress / 100,
            //specify only one: color or gradient
            color: appBarColor,
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [Colors.yellowAccent, Colors.deepOrange],
            // ),
          ),
          CloudButton(
            color: progress == 100.0 ? Colors.green : appBarColor,
            name: progress == 100.0 ? "Upload complete" : "Upload image",
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                Uint8List? file = result.files.first.bytes;
                String fileName = result.files.first.name;
                if (kIsWeb) {
                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Products/$fileName")
                      .putData(file!);
                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then(
                            (downloadUrl) => product.uploadPhoto(downloadUrl));
                      }

                      //  print(progress);
                    });
                  });
                } else {
                  final croppedFile = await ImageCropper().cropImage(
                      sourcePath: result.files.first.path!,
                      compressFormat: ImageCompressFormat.jpg,
                      compressQuality: 80,
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: appBarColor,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                      ]);
                  // uploadTask = ref.putFile(
                  //   io.File(croppedFile!.path),
                  // );

                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Products/$fileName")
                      .putFile(
                        File(croppedFile!.path),
                      );

                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then(
                            (downloadUrl) => product.uploadPhoto(downloadUrl));
                      }

                      //  print(progress);
                    });
                  });
                }
              }
              // valid.vaildtionCheck();
              //valid.vaildtionCheck(true);
            },
          ),
        ],
      );
    });
  }
}

class StoreUplaodPage extends StatefulWidget {
  const StoreUplaodPage({Key? key}) : super(key: key);

  @override
  _StoreUplaodPageState createState() => _StoreUplaodPageState();
}

class _StoreUplaodPageState extends State<StoreUplaodPage> {
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final store = ref.read(storeNotifer);
      // final valid = ref.read(validatorProvider);
      return Column(
        children: [
          ProgressBar(
            //   duration: const Duration(seconds: 3),
            value: progress / 100,
            //specify only one: color or gradient
            color: appBarColor,
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [Colors.yellowAccent, Colors.deepOrange],
            // ),
          ),
          CloudButton(
            color: progress == 100.0 ? Colors.green : appBarColor,
            name: progress == 100.0 ? "Upload complete" : "Upload image",
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                Uint8List? file = result.files.first.bytes;
                String fileName = result.files.first.name;
                if (kIsWeb) {
                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Stores/$fileName")
                      .putData(file!);
                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then(
                            (downloadUrl) => store.upoadPhoto(downloadUrl));
                      }

                      //  print(progress);
                    });
                  });
                } else {
                  final croppedFile = await ImageCropper().cropImage(
                      sourcePath: result.files.first.path!,
                      compressFormat: ImageCompressFormat.jpg,
                      compressQuality: 80,
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: appBarColor,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                      ]);
                  // uploadTask = ref.putFile(
                  //   io.File(croppedFile!.path),
                  // );

                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Stores/$fileName")
                      .putFile(
                        File(croppedFile!.path),
                      );

                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then(
                            (downloadUrl) => store.upoadPhoto(downloadUrl));
                      }

                      //  print(progress);
                    });
                  });
                }
              }
              // valid.vaildtionCheck();
              //valid.vaildtionCheck(true);
            },
          ),
        ],
      );
    });
  }
}

class PostUplaodPage extends StatefulWidget {
  const PostUplaodPage({Key? key}) : super(key: key);

  @override
  _PostUplaodPageState createState() => _PostUplaodPageState();
}

class _PostUplaodPageState extends State<PostUplaodPage> {
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final post = ref.read(postNotifire);
      // final valid = ref.read(validatorProvider);
      return Column(
        children: [
          ProgressBar(
            //   duration: const Duration(seconds: 3),
            value: progress / 100,
            //specify only one: color or gradient
            color: appBarColor,
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [Colors.yellowAccent, Colors.deepOrange],
            // ),
          ),
          CloudButton(
            color: progress == 100.0 ? Colors.green : appBarColor,
            name: progress == 100.0 ? "Upload complete" : "Upload image",
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                Uint8List? file = result.files.first.bytes;
                String fileName = result.files.first.name;
                if (kIsWeb) {
                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Post/$fileName")
                      .putData(file!);
                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then(
                            (downloadUrl) => post.changePostImage(downloadUrl));
                      }

                      //  print(progress);
                    });
                  });
                } else {
                  final croppedFile = await ImageCropper().cropImage(
                      sourcePath: result.files.first.path!,
                      compressFormat: ImageCompressFormat.jpg,
                      compressQuality: 80,
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: appBarColor,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                      ]);
                  // uploadTask = ref.putFile(
                  //   io.File(croppedFile!.path),
                  // );

                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Post/$fileName")
                      .putFile(
                        File(croppedFile!.path),
                      );

                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then(
                            (downloadUrl) => post.changePostImage(downloadUrl));
                      }

                      //  print(progress);
                    });
                  });
                }
              }
              // valid.vaildtionCheck();
              //valid.vaildtionCheck(true);
            },
          ),
        ],
      );
    });
  }
}
