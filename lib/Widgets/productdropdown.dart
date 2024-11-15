import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/streams_providers.dart';

class ProductSuggestonPro extends StatefulWidget {
  final String pro;
  const ProductSuggestonPro({
    super.key,
    this.pro = "Selcet",
    //  required this.storeId,
  });

  @override
  State<ProductSuggestonPro> createState() => _ProductSuggestonPro();
}

class _ProductSuggestonPro extends State<ProductSuggestonPro> {
  dynamic selectedType;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        final productT = ref.watch(getProductSuggtion);
        // final productTypeChange = ref(productPro);
        return productT.when(
            data: (QuerySnapshot value) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CloudButton(
                          // style: OutlinedButton.styleFrom(
                          //     backgroundColor: appBarColor,
                          //     foregroundColor: Colors.white),
                          name: value.docs[index]["productType0"],
                          //    style: textStyle),
                          onPressed: () {
                            WriteCache.setString(
                              key: "proType",
                              value: value.docs[index]["productType0"],
                            );
                            return ref.refresh(getRandomProduct);
                            //html.window.location.reload();
                          },
                        ),
                        CloudButton(
                          name: value.docs[index]["productType1"],
                          onPressed: () {
                            WriteCache.setString(
                              key: "proType",
                              value: value.docs[index]["productType1"],
                            );
                            return ref.refresh(getRandomProduct);
                          },
                        ),
                        CloudButton(
                          name: value.docs[index]["productType2"],
                          onPressed: () {
                            WriteCache.setString(
                              key: "proType",
                              value: value.docs[index]["productType2"],
                            );
                            return ref.refresh(getRandomProduct);
                          },
                        ),
                      ],
                    );
                  });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (value, erorr) {
              return const Center(
                child: Text("No data available"),
              );
            });
      }),
    );
  }
}
