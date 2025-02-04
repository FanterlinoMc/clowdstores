import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/ui/pages/shopping_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Widgets/text-styles.dart';
import '../../helpers/streams_providers.dart';
import '../pages/StoerViews/stores.dart';
import '../store/products/product_suggestion.dart';

class ShoppingFeedWeb extends StatelessWidget {
  const ShoppingFeedWeb({super.key});

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
          return store.when(
            data: (QuerySnapshot value) {
              return ResponsiveVisibility(
                visible: true,
                replacement: const ShoppingFeed(),
                hiddenConditions: const [
                  Condition.smallerThan(
                    name: DESKTOP,
                  )
                ],
                child: ResponsiveRowColumn(
                    rowCrossAxisAlignment: CrossAxisAlignment.start,
                    layout: ResponsiveRowColumnType.ROW,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        child: SizedBox(
                          width: size.width,
                          height: ResponsiveValue(context,
                              defaultValue: 360.0,
                              conditionalValues: [
                                const Condition.smallerThan(
                                  name: TABLET,
                                ),
                              ]).value,
                          child: const Center(child: ProductSuggestion()),
                        ),
                      ),
                      const ResponsiveRowColumnItem(
                        rowFlex: 1,
                        //rowFit: FlexFit,

                        child: ShoppingFeed(),
                      ),
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        //rowFit: FlexFit,
                        child: SizedBox(
                          width: size.width,
                          height: ResponsiveValue(context,
                              defaultValue: 350.0,
                              conditionalValues: [
                                const Condition.smallerThan(
                                    name: TABLET, value: 300.0),
                              ]).value,
                          child: const Stores(),
                        ),
                      ),
                    ]),
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
