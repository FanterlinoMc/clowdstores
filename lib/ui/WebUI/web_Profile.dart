import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/ui/pages/chat_list.dart';
import 'package:clowdstores/ui/pages/welcome_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/streams_providers.dart';
import '../pages/User/cart.dart';
import '../pages/User/free_user.dart';
import '../pages/profile/profile_page.dart';
import '../store/orders.dart';

class WebProfile extends StatelessWidget {
  const WebProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final getStore = ref.watch(getchangeUser);
      return getStore.when(data: (DocumentSnapshot value) {
        if (value.exists) {
          return ResponsiveVisibility(
            visible: true,
            replacement:
                value["isStoreOwner"] ? const UserProfile() : const Profile(),
            hiddenConditions: const [Condition.smallerThan(name: DESKTOP)],
            child: ResponsiveRowColumn(
                layout: ResponsiveRowColumnType.ROW,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    // rowFlex: 1,
                    //  rowFit: FlexFit.tight,
                    child: value["isStoreOwner"]
                        ? const CartPage()
                        : const OrderPage(),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    //rowFit: FlexFit,
                    child: value["isStoreOwner"]
                        ? const UserProfile()
                        : const Profile(),
                  ),
                  const ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: ChatList(),
                  ),
                ]),
          );
        } else {
          return const OpeningView();
        }
        // );
      }, loading: () {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }, error: (stack, erorr) {
        return const OpeningView();
      });
    });
  }
}
