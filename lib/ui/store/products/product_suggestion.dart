import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../helpers/change_notifiiers.dart';
import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/productdropdown.dart';
import '../../../helpers/streams_providers.dart';

class ProductSuggestion extends StatefulWidget {
  const ProductSuggestion({
    Key? key,
  }) : super(key: key);
  @override
  State<ProductSuggestion> createState() => _ProductSuggestionState();
}

class _ProductSuggestionState extends State<ProductSuggestion> {
  @override
  @override
  Widget build(BuildContext contex) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: ((context, ref, child) {
        final router = ref.read(cacheState);
        final getProduct = ref.watch(getRandomProduct);
        return getProduct.when(
          data: (QuerySnapshot value) {
            // ProductModel productModel
            if (value.docs.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: size.width,
                      height: 30,
                      child: const ProductSuggestonPro(),
                    ),
                  ),
                ],
              );
            } else {
              return AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: size.width,
                        height: 60,
                        child: const ProductSuggestonPro(),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () async {
                                router.chanageCollectionName(
                                    value.docs[index]["storeId"]);
                                router.chanageDocId(
                                    value.docs[index]["productId"]);
                                router.routeSates();

                                context.push('/DetaliPage');
                              },
                              child: AnimationConfiguration.staggeredList(
                                position: index,
                                child: ScaleAnimation(
                                  // horizontalOffset: 50.0,
                                  delay: const Duration(milliseconds: 200),
                                  child: FadeInAnimation(
                                    delay: const Duration(milliseconds: 100),
                                    child: SizedBox(
                                      child: Card(
                                        shadowColor: Colors.blueGrey,
                                        elevation: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ExtendedImage.network(
                                              value.docs[index]["photoUrl"] ??
                                                  "No Info",
                                              shape: BoxShape.rectangle,
                                              fit: BoxFit.fitHeight,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              height: 210,
                                              width: 170,
                                              enableMemoryCache: true,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Wrap(
                                                clipBehavior: Clip.antiAlias,
                                                direction: Axis.vertical,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  Text(
                                                      value.docs[index]["name"],
                                                      maxLines: 1,
                                                      style: textStyle),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          value.docs[index]
                                                                  ["price"]
                                                              .toString(),
                                                          style: textStyle),
                                                      const Text(
                                                        "EGP",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      //  const Text("EGP")
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          error: (vakue, stack) => const Center(child: Text("No data ")),
        );
      }),
    );
  }
}
