import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../helpers/responive.dart';
import '../../../helpers/streams_providers.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final getCartPro = ref.watch(getCart);
      return Scaffold(
        extendBodyBehindAppBar: true,
        body: getCartPro.when(
            data: (QuerySnapshot value) {
              return Center(
                child: SizedBox(
                  width: ResponsiveValue(context,
                      defaultValue: 1000.0,
                      valueWhen: [
                        const Condition.smallerThan(
                          name: TABLET,
                          value: tW,
                        ),
                        const Condition.smallerThan(
                          name: DESKTOP,
                          value: mW,
                        ),
                      ]).value,
                  child: CustomScrollView(slivers: <Widget>[
                    const SliverAppBar(
                      leading: kIsWeb
                          ? SizedBox.shrink()
                          : BackButton(color: appBarColor),
                      backgroundColor: kIsWeb ? Colors.white : appBarColor,
                    ),
                    SliverGrid(
                      gridDelegate: const ResponsiveGridDelegate(
                          crossAxisExtent: 220,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 1),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Card(
                                  // shape: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(0),
                                  //   borderSide: const BorderSide(color: appBarColor),
                                  // ),
                                  shadowColor: Colors.blueGrey,
                                  elevation: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: ExtendedImage.network(
                                          value.docs[index]
                                                  ["productPhotoUrl"] ??
                                              "No Info",
                                          shape: BoxShape.rectangle,
                                          fit: BoxFit.cover,
                                          //      color: Colors.white12,

                                          borderRadius:
                                              BorderRadius.circular(10),
                                          //  scale: 1,
                                          height: 210,
                                          width: 190,

                                          enableMemoryCache: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
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
