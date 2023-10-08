import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../helpers/responive.dart';

class InfoCloumn extends StatelessWidget {
  final DocumentSnapshot? storeInfo;

  const InfoCloumn({
    Key? key,
    this.storeInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = Uri(
      scheme: "https",
      host: storeInfo?["webAddress"],
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width:
            ResponsiveValue(context, defaultValue: 700.0, conditionalValues: [
          Condition.smallerThan(name: TABLET, value: tW),
          Condition.smallerThan(name: DESKTOP, value: mW),
        ]).value,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Row(
                children: [
                  Text(
                    "About",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                children: [
                  Text(storeInfo?["categories"], style: textStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(storeInfo?["city"], style: textStyle),
                ],
              ),
            ),
            Row(
              children: [
                TextButton(
                  child: Text(storeInfo?["webAddress"], style: textStyle),
                  onPressed: () {
                    launchUrl(url);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
