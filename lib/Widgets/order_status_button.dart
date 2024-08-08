import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:clowdstores/helpers/streams_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'button.dart';

class OrderStatusButton extends StatelessWidget {
  const OrderStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final statusState = ref.read(cacheState);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            CloudButton(
              name: "pending",
              onPressed: () {
                statusState.chanageRandomString("pending");
                statusState.routeSates();
                ref.invalidate(getStoreOrders);
              },
            ),
            CloudButton(
              name: "picked Up",
              onPressed: () {
                statusState.chanageRandomString("pickedUp");
                statusState.routeSates();
                ref.invalidate(getStoreOrders);
              },
            ),
            CloudButton(
              name: "Complated",
              onPressed: () {
                statusState.chanageRandomString("Complated");
                statusState.routeSates();
                ref.invalidate(getStoreOrders);
              },
            ),
          ],
        ),
      );
    });
  }
}
