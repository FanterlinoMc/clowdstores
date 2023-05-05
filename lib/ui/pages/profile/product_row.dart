import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:clowdstores/helpers/streams_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../Data/fire_store_streams.dart';

class ProductRow extends StatelessWidget {
  final String? userProduct;
  final String? productProfile;
  const ProductRow({
    this.userProduct,
    Key? key,
    this.productProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final product = ref.watch(productRow);
      final router = ref.read(routerState);

      return product.when(
        data: (QuerySnapshot val) {
          if (val.docs.isEmpty) {
            return const Center(child: Text("No Product found"));
          }
          return SizedBox(
            height: 50,
            width: size.width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Card(
                      shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarColor,
                          // width: 2.5,
                        ),
                      ),
                      shadowColor: Colors.black87,
                      elevation: 5,
                      color: appBarColor,
                      child: InkWell(
                        child: Center(
                          child: Text(
                              val.docs[0]["productType0"] ??
                                  "No Product To Show yet",
                              style: rowStyle),
                        ),
                        onTap: () {
                          router.chanageRouterId(val.docs[0]["storeId"]);
                          router
                              .chanagesubRouterId(val.docs[0]["productType0"]);
                          router.routeSates();

                          context.push(
                            '/ProductView',
                          );
                          return ref.refresh(productRow);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarColor,
                          // width: 2.5,
                        ),
                      ),
                      shadowColor: Colors.black87,
                      elevation: 5,
                      color: appBarColor,
                      child: InkWell(
                        child: Center(
                          child: Text(
                              val.docs[0]["productType1"] ??
                                  "No Product To Show yet",
                              style: rowStyle),
                        ),
                        onTap: () {
                          router.chanageRouterId(val.docs[0]["storeId"]);
                          router
                              .chanagesubRouterId(val.docs[0]["productType1"]);
                          router.routeSates();
                          context.push(
                            '/ProductView',
                          );
                          return ref.refresh(productRow);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: appBarColor,
                          // width: 2.5,
                        ),
                      ),
                      shadowColor: Colors.black87,
                      elevation: 5,
                      color: appBarColor,
                      child: InkWell(
                        child: Center(
                          child: Text(
                              val.docs[0]["productType2"] ??
                                  "No Product To Show yet",
                              style: rowStyle),
                        ),
                        onTap: () {
                          router.chanageRouterId(val.docs[0]["storeId"]);
                          router
                              .chanagesubRouterId(val.docs[0]["productType2"]);
                          router.routeSates();
                          context.push('/ProductView');
                          return ref.refresh(productRow);
                        },
                      ),
                    ),
                  ),
                ]),
          );
        },
        loading: () => const Center(child: SizedBox()),
        error: (val, stack) => const Center(child: Text("Erorr")),
      );
    });
  }
}
