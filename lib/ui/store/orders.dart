import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Data/fire_store_streams.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/streams_providers.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final getOrder = ref.watch(getOrders);
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: getOrder.when(
            data: (QuerySnapshot value) {
              if (value.docs.isEmpty) {
                const Center(child: Text("No Orders Yet"));
              } else {
                return AnimationLimiter(
                  child: CustomScrollView(slivers: <Widget>[
                    const SliverAppBar(
                      centerTitle: true,
                      leading:
                          kIsWeb ? SizedBox() : BackButton(color: appBarColor),
                      backgroundColor: kIsWeb ? Colors.white : appBarColor,
                      title: Text(
                        "Order's",
                        style: TextStyle(
                          fontSize: 26,
                          color: kIsWeb ? appBarColor : Colors.white,
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: const ResponsiveGridDelegate(
                          crossAxisExtent: 220,
                          childAspectRatio: 0.5,
                          crossAxisSpacing: 0),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: value.docs.length,
                            position: index,
                            child: SlideAnimation(
                              delay: const Duration(milliseconds: 300),
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                delay: const Duration(milliseconds: 200),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Card(
                                    shadowColor: Colors.blueGrey,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ExtendedImage.network(
                                          value.docs[index]
                                                  ["productPhotoUrl"] ??
                                              "No Info",
                                          shape: BoxShape.rectangle,
                                          fit: BoxFit.cover,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          height: 220,
                                          width: 200,
                                          enableMemoryCache: true,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                               Text(
                                                "Name",
                                                style: subTextStyle,
                                              ),
                                              Text(
                                                  value.docs[index]
                                                      ["productName"],
                                                  style: textStyle),
                                               Text(
                                                "price",
                                                style: subTextStyle,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      value.docs[index]
                                                              ["productPrice"]
                                                          .toString(),
                                                      style: textStyle),
                                                   Text("EGP",
                                                      style: textStyle)
                                                ],
                                              ),
                                               Text(
                                                "Ordre name",
                                                style: subTextStyle,
                                              ),
                                              Text(
                                                  value.docs[index]["userName"],
                                                  style: textStyle),
                                               Text(
                                                "Customer Number",
                                                style: subTextStyle,
                                              ),
                                              Text(
                                                  value.docs[index]
                                                      ["userNumber"],
                                                  style: textStyle),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: value.docs.length,
                      ),
                    ),
                  ]),
                );
              }
              return null;
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
