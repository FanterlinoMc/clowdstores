import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:clowdstores/helpers/streams_providers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Widgets/coming_soon.dart';
import '../../../Widgets/sizeBox.dart';
import '../../../Widgets/text-styles.dart';

class UserOrders extends StatelessWidget {
  const UserOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final getOrders = ref.watch(getUserOrders);
      final route = ref.read(cacheState);
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: getOrders.when(
            data: (QuerySnapshot value) {
              return CustomScrollView(slivers: <Widget>[
                ClowdSliverAppBar(
                  title: const Text("My Order"),
                ),
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
                      childAspectRatio: ResponsiveValue(context,
                          defaultValue: size.aspectRatio / 3,
                          conditionalValues: [
                            Condition.smallerThan(
                              name: TABLET,
                              value: size.aspectRatio / 0.8,
                            ),
                          ]).value,
                      crossAxisSpacing: 0),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Card(
                              shadowColor: Colors.blueGrey,
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ImageSizeBox(
                                    child: ExtendedImage.network(
                                      value.docs[index]["photoUrl"] ??
                                          "No Info",
                                      shape: BoxShape.rectangle,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(10),
                                      enableMemoryCache: true,
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(value.docs[index]["name"],
                                            style: subTextStyle),
                                        Text(
                                          value.docs[index]["store"],
                                          style: textStyle,
                                        ),
                                        Text(
                                          '${value.docs[index]["price"]}EP'
                                              .toString(),
                                          style: textStyle,
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
              ]);
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
