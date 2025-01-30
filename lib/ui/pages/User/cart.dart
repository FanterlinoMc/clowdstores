import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Widgets/sizeBox.dart';
import '../../../Widgets/text-styles.dart';
import '../../../helpers/streams_providers.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final getCartPro = ref.watch(getCart);
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: getCartPro.when(
            data: (QuerySnapshot value) {
              return CustomScrollView(slivers: <Widget>[
                ClowdSliverAppBar(),
                SliverGrid(
                  gridDelegate: ResponsiveGridDelegate(
                      crossAxisExtent: size.width / 2,
                      childAspectRatio: 0.3,
                      //   mainAxisSpacing: 0.1,
                      crossAxisSpacing: 0),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Card(
                              shadowColor: Colors.blueGrey,
                              elevation: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ImageSizeBox(
                                    child: ExtendedImage.network(
                                      value.docs[index]["productPhotoUrl"] ??
                                          "No Info",
                                      shape: BoxShape.rectangle,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        const Text("Name", style: subTextStyle),
                                        Text(value.docs[index]["productName"],
                                            style: subTextStyle),
                                        const Text("storeName",
                                            style: subTextStyle),
                                        Text(
                                          value.docs[index]["storeName"],
                                          style: textStyle,
                                        ),
                                        Text(
                                          '${value.docs[index]["productPrice"]}EP'
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
