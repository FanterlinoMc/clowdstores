import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/sizeBox.dart';
import '../../../Widgets/text-styles.dart';
import '../../../helpers/responive.dart';
import '../../../helpers/streams_providers.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final getCartPro = ref.watch(getCart);
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: getCartPro.when(
            data: (QuerySnapshot value) {
              return Center(
                child: WebSizeBox(
                  child: CustomScrollView(slivers: <Widget>[
                    const SliverAppBar(
                      title: Text(
                        "Cart",
                        style: TextStyle(color: appBarColor),
                      ),
                      leading: kIsWeb
                          ? SizedBox.shrink()
                          : BackButton(color: appBarColor),
                      backgroundColor: kIsWeb ? Colors.white : appBarColor,
                    ),
                    SliverGrid(
                      gridDelegate: const ResponsiveGridDelegate(
                          crossAxisExtent: 190,
                          childAspectRatio: 0.5,
                          //   mainAxisSpacing: 0.1,
                          crossAxisSpacing: 0),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Card(
                                  shadowColor: Colors.blueGrey,
                                  elevation: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ImageSizeBox(
                                        child: ExtendedImage.network(
                                          value.docs[index]
                                                  ["productPhotoUrl"] ??
                                              "No Info",
                                          shape: BoxShape.rectangle,
                                          fit: BoxFit.cover,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          enableMemoryCache: true,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Name"),
                                          Text(
                                            value.docs[index]["productName"],
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("price"),
                                          Row(
                                            children: [
                                              Text(
                                                value.docs[index]
                                                        ["productPrice"]
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const Text("EGP")
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("storeName"),
                                          Text(
                                            value.docs[index]["storeName"],
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        childCount: value.docs.length,
                      ),
                    ),
                  ]),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (value, stack) {
              return const Center(
                child: Text("Erorr"),
              );
            }),
      );
    });
  }
}
