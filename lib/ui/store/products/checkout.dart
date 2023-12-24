import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/button.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:clowdstores/helpers/streams_providers.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/Froms/check_from.dart';
import '../../../Widgets/text-styles.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    //todo fix the size of the product Image
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ClowdSliverAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Consumer(
                  builder: (context, ref, child) {
                    final checkOut = ref.watch(getCheckOut);
                    final getProduct = ref.read(getCheckOut);
                    return checkOut.when(
                        data: (QuerySnapshot value) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //alignment: WrapAlignment.start,
                                  children: [
                                    ExtendedImage.network(
                                      value.docs[index]["photoUrl"],
                                      height: 200,
                                      width: 210,
                                    ),
                                    Text(value.docs[index]['name'],
                                        style: textStyle),
                                    Text('${value.docs[index]['price']}EG',
                                        style: textStyle),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Add your shipping information"),
                              ),
                              const CheckFrom(),
                              CloudButton(
                                name: "CheckOut",
                                onPressed: () {
                                  // getP
                                },
                              ),
                            ],
                          );
                        },
                        error: (stack, error) {
                          return const Text("error");
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()));
                  },
                );

                // <Widget>[

                // ],
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
