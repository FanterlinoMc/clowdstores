import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
                  child: CustomScrollView(slivers: <Widget>[
                    ClowdSliverAppBar(
                      title: Text(
                        value.docs[0]["categories"],
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: ResponsiveGridDelegate(
                          crossAxisExtent: ResponsiveValue(context,
                              defaultValue: size.width / 7,
                              conditionalValues: [
                                Condition.smallerThan(
                                  name: TABLET,
                                  value: size.width / 2,
                                ),
                              ]).value,
                          childAspectRatio: 0.5,
                          //   mainAxisSpacing: 0.1,
                          crossAxisSpacing: 0),
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
                            child: Card(
                              shadowColor: Colors.blueGrey,
                              elevation: 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExtendedImage.network(
                                    value.docs[index]["photoUrl"] ?? "No Info",
                                    shape: BoxShape.rectangle,
                                    fit: BoxFit.cover,
                                    height: 260,
                                    width: 210,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  Center(
                                    child: Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.start,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.center,
                                      children: [
                                        const Text("business Name",
                                            style: subTextStyle),
                                        Text(value.docs[index]["businessName"],
                                            style: textStyle),
                                        const Text("city", style: subTextStyle),
                                        Text(value.docs[index]["city"],
                                            style: textStyle),
                                        // const Text("category",
                                        //     style: subTextStyle),
                                        // Text(
                                        //     value.docs[index]["categories"],
                                        //     style: textStyle),
                                      ],
                                    ),
                                  ),
                                ],
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
