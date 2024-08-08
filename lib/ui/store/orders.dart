import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Widgets/order_status_button.dart';
import '../../Widgets/text-styles.dart';
import '../../helpers/streams_providers.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final getOrder = ref.watch(getStoreOrders);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
        ),
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: getOrder.when(
            data: (QuerySnapshot value) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 60,
                        child: const OrderStatusButton(),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: AnimationLimiter(
                          child: CustomScrollView(slivers: <Widget>[
                            SliverGrid(
                              gridDelegate: ResponsiveGridDelegate(
                                  crossAxisExtent: ResponsiveValue(context,
                                      defaultValue: size.width / 8,
                                      conditionalValues: [
                                        Condition.smallerThan(
                                          name: TABLET,
                                          value: size.width / 2,
                                        ),
                                      ]).value,
                                  //  kIsWeb ? size.width / 2 : size.width / 2,
                                  childAspectRatio: ResponsiveValue(context,
                                      defaultValue: size.aspectRatio / 3,
                                      conditionalValues: [
                                        Condition.smallerThan(
                                          name: TABLET,
                                          value: size.aspectRatio / 0.9,
                                        ),
                                      ]).value,
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
                                        delay:
                                            const Duration(milliseconds: 200),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Card(
                                            shadowColor: Colors.blueGrey,
                                            elevation: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ExtendedImage.network(
                                                  value.docs[index]
                                                          ["photoUrl"] ??
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          value.docs[index]
                                                              ["name"],
                                                          style: textStyle),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              value.docs[index]
                                                                      ["price"]
                                                                  .toString(),
                                                              style: textStyle),
                                                          const Text("EGP",
                                                              style: textStyle)
                                                        ],
                                                      ),
                                                      Text(
                                                          value.docs[index]
                                                              ["userName"],
                                                          style: textStyle),
                                                      Text(
                                                          value.docs[index]
                                                              ["userPhone"],
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
                        ),
                      ),
                    ],
                  ),
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
