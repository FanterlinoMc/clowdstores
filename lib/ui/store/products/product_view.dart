import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../helpers/change_notifiiers.dart';
import '../../../helpers/streams_providers.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext contex) {
    // final size = MediaQuery.of(contex).size;
    return Scaffold(body: Consumer(
      builder: ((context, ref, child) {
        final router = ref.read(cacheState);
        final getProduc = ref.watch(getProduct);
        return getProduc.when(
          data: (QuerySnapshot value) {
            // ProductModel productModel
            if (value.docs.isEmpty) {
              return const Center(
                child: Text("No Product Add"),
              );
            } else {
              return AnimationLimiter(
                child: CustomScrollView(
                  slivers: <Widget>[
                    const SliverAppBar(
                      leading: kIsWeb
                          ? SizedBox.shrink()
                          : BackButton(color: appBarColor),
                      backgroundColor: kIsWeb ? Colors.white : appBarColor,
                      title: Text(
                        "Product",
                        style: TextStyle(color: appBarColor),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: const ResponsiveGridDelegate(
                          crossAxisExtent: 180,
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
                                  onLongPress: () {
                                    context.push(
                                      '/EditProduct',
                                      extra: value.docs[index],
                                    );
                                  },
                                  onTap: () {
                                    router.chanageCollectionName(
                                        value.docs[index]["storeId"]);
                                    router.chanageDocId(
                                        value.docs[index]["productId"]);
                                    router.routeSates();
                                    context.push('/DetaliPage');
                                    return ref.refresh(getProductDetail);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shadowColor: Colors.blueGrey,
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          ExtendedImage.network(
                                            value.docs[index]["photoUrl"] ??
                                                "No Info",
                                            shape: BoxShape.rectangle,
                                            fit: BoxFit.cover,
                                            height: 210,
                                            width: 170,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            enableMemoryCache: true,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Text(value.docs[index]["name"],
                                                    maxLines: 2,
                                                    style: textStyle),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        value.docs[index]
                                                                ["price"]
                                                            .toString(),
                                                        style: subTextStyle),
                                                    const Text("EGP",
                                                        style: textStyle),
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
    ));
  }
}
