import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Widgets/text-styles.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';
import 'home_page.dart';

class ShoppingFeed extends StatelessWidget {
  const ShoppingFeed({super.key});
  //  SizedBox(
  //                 width: size.width,
  //                 height: ResponsiveValue(context,
  //                     defaultValue: 360.0,
  //                     conditionalValues: [
  //                       Condition.smallerThan(name: TABLET, value: 300.0),
  //                     ]).value,
  //                 child: const ProductSuggestion(),
  //               ),

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool isScreenWide = MediaQuery.of(context).size.width >= 1200;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: isScreenWide ? Colors.white : appBarColor,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final store = ref.watch(getPost);
          final cart = ref.read(cartNotifer);

          return store.when(
            data: (QuerySnapshot value) {
              return Center(
                child: SizedBox(
                  width: isScreenWide ? 600 : size.width,
                  child: CustomScrollView(
                    slivers: [
                      const SliverAppBar(
                        backgroundColor: Colors.white,
                        flexibleSpace: HomeCard(),
                        expandedHeight: 80,
                        collapsedHeight: 100,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            value.docs[index]["storeProfile"]),
                                      ),
                                      title: Column(
                                        children: [
                                          Text(value.docs[index]["storeName"],
                                              style: textStyle),
                                          Text(
                                              value.docs[index]["postCategory"],
                                              style: const TextStyle(
                                                  color: appBarColor,
                                                  fontSize: 13)),
                                        ],
                                      ),
                                      // subtitle: Text(
                                      //     value.docs[index]["postCategory"]),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.more_horiz_outlined),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          value.docs[index]["postContent"],
                                          style: textStyle),
                                    ),
                                    ExtendedImage.network(
                                      value.docs[index]["postImage"],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    //!change the button functionality
                                                    // cart.chnageProductName(value
                                                    //     .docs[index]["name"]);
                                                    // cart.chnageProductPrice(
                                                    //     value.docs[index]
                                                    //         ["price"]);

                                                    // cart.chnageProductproductPhotoUrl(
                                                    //     value.docs[index]
                                                    //         ["photoUrl"]);
                                                    // cart
                                                    //     .chnageUserName(
                                                    //       value.docs[index]
                                                    //           ["storeName"],
                                                    //     )
                                                    //     .toString();
                                                    // // cart.chnageStoreNumber(
                                                    // //     value.docs[index]["storeNumber"]);
                                                    // cart.chnagestoreId(
                                                    //     value.docs[index]
                                                    //         ["storeId"]);
                                                    // cart.chnageProductId(
                                                    //     value.docs[index]
                                                    //         ["productId"]);
                                                    // cart.chnageProductType(
                                                    //     value.docs[index]
                                                    //         ["productType"]);
                                                    // cart.saveCart();
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .add_shopping_cart_outlined,
                                                    size: 25,
                                                  )),
                                              const Text("Add to Cart",
                                                  style: subTextStyle),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("shear",
                                                  style: subTextStyle),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.share_outlined,
                                                    size: 25,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: value.docs.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (value, stack) => const Center(child: Text("error")),
          );
        },
      ),
    );
  }
}
