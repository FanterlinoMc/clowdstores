import 'dart:io';

import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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
      return InkWell(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            Uint8List? file = result.files.first.bytes;
            String fileName = result.files.first.name;
            if (kIsWeb) {
              UploadTask task = FirebaseStorage.instance
                  .ref()
                  .child("Product/$fileName")
                  .putData(file!);
              task.snapshotEvents.listen((event) {
                setState(() {
                  progress = ((event.bytesTransferred.toDouble() /
                              event.totalBytes.toDouble()) *
                          100)
                      .roundToDouble();

                  if (progress == 100) {
                    event.ref
                        .getDownloadURL()
                        .then((downloadUrl) => product.uploadPhoto(downloadUrl))
                        .whenComplete(() => progress = 0.0);
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
                  .child("Product/$fileName")
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
                    event.ref
                        .getDownloadURL()
                        .then((downloadUrl) => product.uploadPhoto(downloadUrl))
                        .whenComplete(() => progress = 0.0);
                  }

                  //  print(progress);
                });
              });
            }
          }
        },
        // child: const Text("Upload File to Firebase Storage"),

        // const SizedBox(
        //   height: 50.0,
        // ),
        child: SizedBox(
          height: 50.0,
          width: 230.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 375),
            child: LiquidLinearProgressIndicator(
              value: progress / 100,
              valueColor: const AlwaysStoppedAnimation(appBarColor),
              backgroundColor: Colors.white,
              direction: Axis.horizontal,
              center: progress == 100.0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.check_rounded,
                          color: Colors.green,
                        ),
                        Text(
                          'Upload Complete',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    )
                  : const Text(
                      "Upload Image",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
            ),
          ),
        ),
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
      final valid = ref.read(validatorProvider);
      return SizedBox(
        height: 50.0,
        width: 230.0,
        child: InkWell(
          onTap: () async {
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

                    if (progress == 99.5) {
                      event.ref
                          .getDownloadURL()
                          .then((downloadUrl) => store.upoadPhoto(downloadUrl));
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
                      event.ref
                          .getDownloadURL()
                          .then((downloadUrl) => store.upoadPhoto(downloadUrl));
                    }

                    //  print(progress);
                  });
                });
              }
            }
            // valid.vaildtionCheck();
            //valid.vaildtionCheck(true);
          },
          // child: const Text("Upload File to Firebase Storage"),

          // const SizedBox(
          //   height: 50.0,
          // ),
          child: SizedBox(
            height: 50.0,
            width: 230.0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 375),
              child: LiquidLinearProgressIndicator(
                value: progress / 100,
                valueColor: const AlwaysStoppedAnimation(appBarColor),
                backgroundColor: Colors.white,
                direction: Axis.horizontal,
                center: progress == 100.0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_rounded,
                            color: Colors.green,
                          ),
                          Text(
                            'Upload Complete',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      )
                    : const Text(
                        "Upload Image",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
