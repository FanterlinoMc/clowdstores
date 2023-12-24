import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Data/fire_store_streams.dart';
import '../../Widgets/text-styles.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class Categories extends StatelessWidget {
  // final String cateName;
  const Categories({
    super.key,
    //  required this.cateName,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final getCategroy = ref.watch(getCategroise);
      final router = ref.read(cacheState);
      final size = MediaQuery.of(context).size;

      return Scaffold(
        body: getCategroy.when(
            data: (QuerySnapshot value) {
              if (value.docs.isEmpty) {
                const Center(
                  child: Text("there's no stores in this category yet"),
                );
              } else {
                return Center(
                  child: SizedBox(
                    width: ResponsiveValue(context,
                        defaultValue: 1000.0,
                        conditionalValues: [
                          Condition.smallerThan(
                            name: DESKTOP,
                            value: size.width,
                          ),
                        ]).value,
                    child: CustomScrollView(slivers: <Widget>[
                      ClowdSliverAppBar(
                        title: Text(
                          value.docs[0]["categories"],
                          style: const TextStyle(
                            color: appBarColor,
                          ),
                        ),
                      ),
                      SliverGrid(
                        gridDelegate: const ResponsiveGridDelegate(
                            crossAxisExtent: 220,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 1),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                router.chanageRandomString(
                                    value.docs[index]["userId"]);
                                router.routeSates();
                                context.push(
                                  '/ProfileView',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 13, top: 5, bottom: 5),
                                child: Card(
                                  shadowColor: Colors.blueGrey,
                                  elevation: 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ExtendedImage.network(
                                        value.docs[index]["photoUrl"] ??
                                            "No Info",
                                        shape: BoxShape.rectangle,
                                        fit: BoxFit.cover,
                                        height: 190,
                                        width: 210,
                                        borderRadius: BorderRadius.circular(10),
                                        enableMemoryCache: true,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("business Name",
                                                style: subTextStyle),
                                            Text(
                                                value.docs[index]
                                                    ["businessName"],
                                                style: textStyle),
                                            const Text("city",
                                                style: subTextStyle),
                                            Text(value.docs[index]["city"],
                                                style: textStyle),
                                            const Text("category",
                                                style: subTextStyle),
                                            Text(
                                                value.docs[index]["categories"],
                                                style: textStyle),
                                          ],
                                        ),
                                      ),
                                    ],
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
