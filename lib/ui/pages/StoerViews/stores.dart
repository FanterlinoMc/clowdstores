import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/text-styles.dart';
import '../../../helpers/change_notifiiers.dart';
import '../../../helpers/streams_providers.dart';

class Stores extends StatelessWidget {
  const Stores({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext contex) {
    // final size = MediaQuery.of(contex).size;
    return Consumer(
      builder: ((context, ref, child) {
        final router = ref.read(cacheState);
        final stores = ref.watch(getStores);
        return stores.when(
          data: (QuerySnapshot value) {
            // ProductModel productModel
            if (value.docs.isEmpty) {
              return const Center(
                child: Text("No Stores"),
              );
            } else {
              return AnimationLimiter(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: const ResponsiveGridDelegate(
                          crossAxisExtent: 210,
                          childAspectRatio: 0.6,
                          //   mainAxisSpacing: 0.1,
                          crossAxisSpacing: 0),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: value.docs.length,
                            child: ScaleAnimation(
                              delay: const Duration(milliseconds: 200),
                              // verticalOffset: 50.0,
                              child: FadeInAnimation(
                                delay: const Duration(milliseconds: 100),
                                child: InkWell(
                                  // onLongPress: () {
                                  //   context.push(
                                  //     '/EditProduct',
                                  //     extra: value.docs[index],
                                  //   );
                                  // },
                                  onTap: () {
                                    router.chanageRandomString(
                                        value.docs[index]["userId"]);
                                    // router.chanageDocId(
                                    //     value.docs[index]["productId"]);
                                    router.routeSates();
                                    context.push('/ProfileView');
                                    return ref.refresh(getProductDetail);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: SizedBox(
                                      height: 180,
                                      width: 160,
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
                                              fit: BoxFit.cover,
                                              height: 260,
                                              width: 190,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              enableMemoryCache: true,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      value.docs[index]
                                                          ["businessName"],
                                                      maxLines: 1,
                                                      style: subTextStyle),
                                                  Text(
                                                      value.docs[index]
                                                          ["categories"],
                                                      maxLines: 1,
                                                      style: subTextStyle),
                                                  Text(
                                                      value.docs[index]
                                                          ["businesaddress"],
                                                      maxLines: 1,
                                                      style: subTextStyle),
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
                            ),
                          );
                        },
                        childCount: value.docs.length,
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
          error: (vakue, stack) => Center(
              child: TextButton(
            child: const Text("Refresh"),
            onPressed: () {
              return ref.refresh(getProduct);
            },
          )),
        );
      }),
    );
  }
}
