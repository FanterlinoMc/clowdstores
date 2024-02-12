import 'package:clowdstores/Widgets/coming_soon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../Widgets/text-styles.dart';
import '../../../helpers/change_notifiiers.dart';

// ignore: must_be_immutable
class TextProRow extends StatelessWidget {
  late dynamic searchInfo;
  TextProRow({super.key, this.searchInfo});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      // final saveRoom = ref.watch(sendMessageNotifer);
      // final review = ref(addReview);
      final router = ref.read(cacheState);
      return LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const ComingSoon();
                        });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.favorite_outline_outlined,
                            size: 24, color: Colors.red),
                        Text("favorite", style: rowTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: () {
                    router.chanageRandomString(
                      searchInfo!['userId'],
                    );
                    router.routeSates();
                    print(
                      searchInfo!['userId'],
                    );
                    context.push("/ReviewPage");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.reviews_outlined,
                            size: 24, color: Colors.indigo),
                        Text(
                          "Review",
                          style: rowTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: () {
                    router.chanageLat(
                      searchInfo!['latitude'],
                    );
                    router.chanageLng(
                      searchInfo!['longitude'],
                    );
                    router.chanageRandomMap(
                      searchInfo!['categories'],
                    );
                    router.routeSates();
                    context.push("/NearMe");
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return ComingSoon();
                    //     });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 24,
                          color: Colors.orange,
                        ),
                        Text("Location", style: rowTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: () {
                    context.push("/ChatList");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.message_outlined,
                            size: 24, color: Colors.blue),
                        Text("Chats", style: rowTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      });
    });
  }
}
