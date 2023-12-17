import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/coming_soon.dart';
import '../../../helpers/change_notifiiers.dart';
import '../../../helpers/responive.dart';
import '../../../helpers/streams_providers.dart';

class DetaliPage extends StatelessWidget {
  const DetaliPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      final order = ref.read(orderNotifer);
      final cart = ref.read(cartNotifer);
      final getProductD = ref.watch(getProductDetail);
      final router = ref.read(cacheState);
      final clowdlink = ref.read(clowdLink);

      return getProductD.when(
          data: (QuerySnapshot value) {
            return Center(
              child: SizedBox(
                width: ResponsiveValue(context,
                    defaultValue: 800.0,
                    conditionalValues: [
                      Condition.smallerThan(
                        name: DESKTOP,
                        value: tW,
                      ),
                    ]).value,
                child: CustomScrollView(
                  slivers: <Widget>[
                    ClowdSliverAppBar(),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return Column(
                        children: [
                          ExtendedImage.network(
                            value.docs[index]["photoUrl"],
                            shape: BoxShape.rectangle,
                            fit: BoxFit.fitWidth,
                            height: size.height / 3,
                            //  width: 270,
                            enableMemoryCache: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  router.chanageRandomString(
                                    value.docs[index]["storeId"],
                                  );
                                  router.routeSates();
                                  context.push('/ProfileView');
                                },
                                child: SizedBox(
                                  width: ResponsiveValue(context,
                                      defaultValue: 800.0,
                                      conditionalValues: [
                                        Condition.smallerThan(
                                            name: TABLET,
                                            value: size.width / 1.3),
                                      ]).value,
                                  child: Card(
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(11),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    shadowColor: Colors.blueGrey,
                                    elevation: 5,
                                    child: Row(
                                      children: [
                                        ExtendedImage.network(
                                          value.docs[index]["storephotoUrl"],
                                          fit: BoxFit.fitHeight,
                                          height: 60,
                                          width: 60,
                                        ),
                                        Text(value.docs[index]["storeName"],
                                            style: textStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              kIsWeb
                                  ? const SizedBox()
                                  : FloatingActionButton.extended(
                                      //   hoverColor: Colors.white,
                                      backgroundColor: appBarColor,
                                      onPressed: () {
                                        clowdlink.changeDescription(
                                            value.docs[index]["description"]);
                                        clowdlink.changeImage(
                                            value.docs[index]["photoUrl"]);
                                        clowdlink.changeTitle(
                                            value.docs[index]["name"]);
                                        clowdlink.changeProductId(
                                            value.docs[index]["productId"]);
                                        clowdlink.changeUserId(
                                            value.docs[index]["storeId"]);
                                        clowdlink.changePrice(value.docs[index]
                                                ["price"]
                                            .toString());
                                        clowdlink.createProductLink();
                                      },
                                      label: const Icon(
                                        Icons.share_sharp,
                                        color: Colors.white,
                                      ),
                                      //  icon: const Icon(Icons.location_on_outlined),
                                    )
                              //      : const SizedBox.shrink()
                            ],
                          ),
                          Card(
                            shadowColor: Colors.blueGrey,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Name", style: subTextStyle),
                                  Text(value.docs[index]["name"],
                                      style: textStyle),
                                  const SizedBox(height: 10),
                                  const Text("Description",
                                      style: subTextStyle),
                                  Text(value.docs[index]["description"],
                                      style: textStyle),
                                  const SizedBox(height: 10),
                                  const Text("price", style: subTextStyle),
                                  Row(
                                    children: [
                                      //  Text('${value.docs[index]['price']}EG'),
                                      Text('${value.docs[index]['price']}EG',
                                          style: textStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CloudButton(
                                  elevation: 10,
                                  name: "Add to Cart",
                                  onPressed: () {
                                    cart.chnageProductName(
                                        value.docs[index]["name"]);
                                    cart.chnageProductPrice(
                                        value.docs[index]["price"]);

                                    cart.chnageProductproductPhotoUrl(
                                        value.docs[index]["photoUrl"]);
                                    cart
                                        .chnageUserName(
                                          value.docs[index]["storeName"],
                                        )
                                        .toString();
                                    // cart.chnageStoreNumber(
                                    //     value.docs[index]["storeNumber"]);
                                    cart.chnagestoreId(
                                        value.docs[index]["storeId"]);
                                    cart.chnageProductId(
                                        value.docs[index]["productId"]);
                                    cart.chnageProductType(
                                        value.docs[index]["productType"]);
                                    cart.saveCart();
                                  }),
                              CloudButton(
                                  name: "Checkout",
                                  onPressed: () async {
                                    // order.chnageProductName(
                                    //     value.docs[index]["name"]);
                                    // order.chnageProductPrice(
                                    //     value.docs[index]["price"].toString());

                                    // order.chnageProductproductPhotoUrl(
                                    //     value.docs[index]["photoUrl"]);
                                    // order.chnageUserName(
                                    //     auth.currentUser!.displayName);
                                    // // order.chnageUserNumber(  value.docs[index])

                                    // order.chnageProductId(
                                    //     value.docs[index]["productId"]);
                                    // order.chnageProductType(
                                    //     value.docs[index]["productType"]);
                                    // await showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return UserNumber(
                                    //         storeId: value.docs[index]
                                    //                 ["storeId"]
                                    //             .toString(),
                                    //       );
                                    //     });
                                    router.chanageCollectionName(
                                        value.docs[index]["storeId"]);
                                    router.chanageDocId(
                                        value.docs[index]["productId"]);
                                    router.routeSates();
                                    context.push("/checkOut");
                                    // context.push('/DetaliPage');
                                    return ref.refresh(getCheckOut);
                                  }),
                            ],
                          ),
                        ],
                      );
                    }, childCount: 1))
                  ]

                  // leading: Text(
                  , // ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            return const Center(child: CircularProgressIndicator());
          });
    }));
  }
}
