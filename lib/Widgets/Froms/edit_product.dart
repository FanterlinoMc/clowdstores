import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/helpers/test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../button.dart';
import '../coming_soon.dart';
import '../product_drop.dart';
import '../text_filed.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class EditProduct extends StatefulWidget {
  final dynamic updateProduct;
  const EditProduct({Key? key, this.updateProduct}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _description = TextEditingController();

  final TextEditingController _price = TextEditingController();

  final TextEditingController _quantity = TextEditingController();

  final TextEditingController _productTypeController = TextEditingController();
  @override
  void dispose() {
    _name.dispose();
    _description.dispose();

    _price.dispose();
    _quantity.dispose();
    _productTypeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.updateProduct != null) {
      _name.text = widget.updateProduct["name"] ?? "";
      _description.text = widget.updateProduct["description"] ?? "";

      _price.text = widget.updateProduct["price"].toString();
      _quantity.text = widget.updateProduct["quantity"].toString();
      _productTypeController.text = widget.updateProduct["productType"] ?? "";
    } else {
      _name.text = "";
      _description.text = "";

      _price.text = "";
      _quantity.text = "";
      _productTypeController.text = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, ref, child) {
          final product = ref.read(productPro);
          final productType = ref.watch(productRow);

          return productType.when(
              data: (QuerySnapshot value) {
                if (widget.updateProduct == null) {
                  // context.push("/Profile");
                  const Text("Back to Profile");
                }
                return Center(
                  child: SizedBox(
                    width: ResponsiveValue(context,
                        defaultValue: 500.0,
                        conditionalValues: [
                          const Condition.smallerThan(
                            name: DESKTOP,
                            value: 400.0,
                          ),
                        ]).value,
                    child: CustomScrollView(slivers: [
                      ClowdSliverAppBar(),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              children: <Widget>[
                                MyTextfiled(
                                  maxLength: 15,
                                  labelText: "Name",
                                  hintText: "Name",
                                  controller: _name,
                                  onChanged: (value) => product.changeName(
                                      widget.updateProduct["name"] ?? value),
                                ),
                                MyTextfiled(
                                  labelText: "description",
                                  hintText: "description",
                                  controller: _description,
                                  onChanged: (value) =>
                                      product.changeDescription(
                                          widget.updateProduct["description"] ??
                                              value),
                                ),
                                const SizedBox(height: 20),
                                MyTextfiled(
                                  keyboardType: TextInputType.number,
                                  controller: _price,
                                  onChanged: (value) =>
                                      product.changePrice(value),
                                  labelText: "price",
                                  hintText: "price",
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                MyTextfiled(
                                  keyboardType: TextInputType.number,
                                  controller: _quantity,
                                  onChanged: (value) =>
                                      product.changeQuantity(value),
                                  labelText: "quantity",
                                  hintText: "quantity",
                                ),
                                const ProDrop(),
                                Container(height: 20),
                                const ProductUplaodPage(),
                                // CloudButton(
                                //   name: "Pick an Image",
                                //   onPressed: () {
                                //     // product.changePhoto() ??
                                //     //     product.changePhoto(
                                //     //         value: widget.updateProduct[
                                //     //             "storephotoUrl"]);
                                //   },
                                // ),
                                CloudButton(
                                  name: "SaveProduct",
                                  onPressed: () {
                                    product.changeCity(
                                      widget.updateProduct?["city"],
                                    );

                                    product.changeStoreName(
                                      widget.updateProduct?["storeName"],
                                    );

                                    product.changeLat(
                                      widget.updateProduct?["lattitude"],
                                    );
                                    product.changeLon(
                                      widget.updateProduct?["longitude"],
                                    );
                                    product.changeStorePhotoUrl(
                                      widget.updateProduct?["storephotoUrl"],
                                    );

                                    product.updateProduct(
                                      widget.updateProduct?["productId"],
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (value, stack) => const Center(child: Text("Error")));
        },
      ),
    );
  }
}
