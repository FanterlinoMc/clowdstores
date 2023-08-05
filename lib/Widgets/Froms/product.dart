import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Data/fire_store_streams.dart';
import '../../helpers/test.dart';
import '../button.dart';
import '../product_drop.dart';
import '../text_filed.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class AddProduct extends StatefulWidget {
  final dynamic storeInfo;
  const AddProduct({Key? key, this.storeInfo}) : super(key: key);

  @override
  State<AddProduct> createState() => _ProductState();
}

class _ProductState extends State<AddProduct> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _description = TextEditingController();

  final TextEditingController _price = TextEditingController();

  final TextEditingController _quantity = TextEditingController();

  // final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _productTypeController0 = TextEditingController();
  final TextEditingController _productTypeController1 = TextEditingController();
  final TextEditingController _productTypeController2 = TextEditingController();
  // @override
  // void dispose() {
  //   _name.dispose();
  //   _description.dispose();
  //   _price.dispose();
  //   _quantity.dispose();
  //   _productTypeController0.dispose();
  //   _productTypeController1.dispose();
  //   _productTypeController2.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, ref, child) {
          final product = ref.read(productPro);
          final productType = ref.watch(productRow);
          final validators = ref.read(validatorProvider);
          // UploadTask? uploadTask;
          return productType.when(
              data: (QuerySnapshot value) {
                if (value.docs.isEmpty) {
                  return const Text("back Button");
                } else {
                  return Center(
                    child: SizedBox(
                      width: ResponsiveValue(context,
                          defaultValue: 500.0,
                          conditionalValues: [
                            Condition.smallerThan(
                                name: DESKTOP, value: size.width),
                          ]).value,
                      child: CustomScrollView(
                        slivers: [
                          ClowdSliverAppBar(
                            title: const Text(
                              "Add Product",
                              style: TextStyle(
                                fontSize: 25,
                                color: kIsWeb ? appBarColor : Colors.white,
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Column(
                                  children: <Widget>[
                                    const SizedBox(height: 15),
                                    // CircleAvatar(
                                    //   backgroundImage:
                                    //       NetworkImage(product.photoUrl ?? ""),
                                    //   backgroundColor: Colors.blue,
                                    //   radius: 100,
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       //  context.refresh(productPro)
                                    //       product.changePhoto(
                                    //           uploadingTask: uploadTask);
                                    //     },
                                    //   ),
                                    //   // product.photoUrl ?? "",
                                    //   // //   color: Colors.blue,
                                    //   // handleLoadingProgress: true,
                                    //   // height: 80,
                                    //   // width: 120,
                                    // ),
                                    MyTextfiled(
                                      color: validators.productName
                                          ? appBarColor
                                          : Colors.green,
                                      validator: (value) =>
                                          validators.isProductNameValid(value!),
                                      maxLength: 15,
                                      labelText: "Name",
                                      hintText: "Name",
                                      controller: _name,
                                      onChanged: (value) =>
                                          product.changeName(value),
                                    ),
                                    MyTextfiled(
                                      color: validators.desctiotion
                                          ? appBarColor
                                          : Colors.green,
                                      validator: (value) =>
                                          validators.isDescription(value!),
                                      labelText: "description",
                                      hintText: "description",
                                      controller: _description,
                                      onChanged: (value) =>
                                          product.changeDescription(value),
                                    ),
                                    MyTextfiled(
                                      color: validators.price
                                          ? appBarColor
                                          : Colors.green,
                                      validator: (value) =>
                                          validators.ispriceValid(value!),
                                      keyboardType: TextInputType.number,
                                      controller: _price,
                                      onChanged: (value) =>
                                          product.changePrice(value),
                                      labelText: "price",
                                      hintText: "price",
                                    ),
                                    MyTextfiled(
                                      color: validators.qunantiyy
                                          ? appBarColor
                                          : Colors.green,
                                      validator: (value) =>
                                          validators.isQuantity(value!),
                                      keyboardType: TextInputType.number,
                                      controller: _quantity,
                                      onChanged: (value) =>
                                          product.changeQuantity(value),
                                      labelText: "quantity",
                                      hintText: "quantity",
                                    ),
                                    const ProDrop(),
                                    Container(
                                      height: 20,
                                    ),
                                    const ProductUplaodPage(),
                                    // CloudButton(
                                    //     name: "Pick an Image",
                                    //     onPressed: () {
                                    //       product.changePhoto();
                                    //     }),
                                    CloudButton(
                                      color: validators.qunantiyy
                                          ? Colors.blueGrey
                                          : appBarColor,
                                      name: "SaveProduct",
                                      onPressed: () async {
                                        product.changeCity(
                                            await ReadCache.getString(
                                                key: "city"));

                                        product.changeStoreName(
                                            await ReadCache.getString(
                                                key: "name"));

                                        product.changeLat(
                                            await ReadCache.getDouble(
                                                key: "lat"));
                                        product.changeLon(
                                            await ReadCache.getDouble(
                                                key: "lng"));
                                        product.changeStorePhotoUrl(
                                            await ReadCache.getString(
                                                key: "photoUrl"));

                                        product.saveProduct();

                                        _name.clear();
                                        _price.clear();
                                        _description.clear();
                                        _quantity.clear();

                                        // html.window.location.reload();
                                        return ref.refresh(productPro);
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (value, stack) => const Center(child: Text("error")));
        },
      ),
    );
  }
}