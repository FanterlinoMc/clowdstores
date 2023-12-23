import 'dart:io';

import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:clowdstores/Widgets/button.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class ProductUplaodPage extends StatefulWidget {
  const ProductUplaodPage({super.key});

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
          ),
          CloudButton(
            color: progress == 100.0 ? Colors.green : appBarColor,
            name: progress == 100.0 ? "Done" : "Upload image",
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

//?StoreUplaodPage//////////////////////////////////////////////////////////

class StoreUplaodPage extends StatefulWidget {
  const StoreUplaodPage({super.key});

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
            name: progress == 100.0 ? "Done" : "Upload image",
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

///?PostUplaodPage///////////////////////////////////////////////////////////////////

class PostUplaodPage extends StatefulWidget {
  final dynamic postImage;
  const PostUplaodPage({super.key, this.postImage});

  @override
  _PostUplaodPageState createState() => _PostUplaodPageState();
}

class _PostUplaodPageState extends State<PostUplaodPage> {
  double progress = 0.0;
  String postImage = "";
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final post = ref.read(postNotifire);
      final cacheRoute = ref.read(cacheState);

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
            name: progress == 100.0 ? "Done" : "Upload image",
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                Uint8List? file = result.files.first.bytes;
                String fileName = result.files.first.name;
                if (kIsWeb) {
                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Posts/$fileName")
                      .putData(file!);
                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then((downloadUrl) {
                          post.changePostImage(downloadUrl);
                          cacheRoute.chanagePhotoUrl(downloadUrl);
                          ExtendedImage.network(downloadUrl);
                        });
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
                      .child("Posts/$fileName")
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
                        event.ref.getDownloadURL().then((downloadUrl) {
                          post.changePostImage(downloadUrl);
                          postImage = downloadUrl;
                        });
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
          ExtendedImage.network(postImage),
        ],
      );
    });
  }
}

class UploadVudeo extends StatefulWidget {
  const UploadVudeo({super.key});

  @override
  _UploadVudeoState createState() => _UploadVudeoState();
}

class _UploadVudeoState extends State<UploadVudeo> {
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final post = ref.read(postNotifire);
      final cacheRoute = ref.read(cacheState);
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
            name: progress == 100.0 ? "Done" : "Upload Video",
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                //Uint8List? file = result.files.first.bytes;
                String fileName = result.files.first.name;
                if (kIsWeb) {
                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Videos/$fileName")
                      .putFile(
                        File(result.files.first.path!),
                      );
                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then((downloadUrl) {
                          // post.changeVideoUrl(downloadUrl);
                          cacheRoute.chanagePhotoUrl(downloadUrl);
                        });
                      }

                      //  print(progress);
                    });
                  });
                } else {
                  UploadTask task = FirebaseStorage.instance
                      .ref()
                      .child("Videos/$fileName")
                      .putFile(
                        File(result.files.first.path!),
                      );

                  task.snapshotEvents.listen((event) {
                    setState(() {
                      progress = ((event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble()) *
                              100)
                          .roundToDouble();

                      if (progress == 100) {
                        event.ref.getDownloadURL().then((downloadUrl) {
                          // post.changeVideoUrl(downloadUrl);

                          cacheRoute.chanagePhotoUrl(downloadUrl);
                        });
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
