import 'package:clowdstores/Widgets/coming_soon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../helpers/change_notifiiers.dart';

// ignore: must_be_immutable
class TextProRow extends StatelessWidget {
  late dynamic searchInfo;
  TextProRow({Key? key, this.searchInfo}) : super(key: key);

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
                shape: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    //  width: .5,
                  ),
                ),
                shadowColor: Colors.black87,
                elevation: 5,
                color: Colors.white,
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
                        Text("favorite", style: subTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigo,
                    // width: 2.5,
                  ),
                ),
                shadowColor: Colors.black87,
                elevation: 5,
                color: Colors.white,
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
                          style: subTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    // width: 2.5,
                  ),
                ),
                shadowColor: Colors.black87,
                elevation: 5,
                color: Colors.white,
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
                        Text("Location", style: subTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blue,
                  // width: 2.5,
                )),
                shadowColor: Colors.black87,
                elevation: 5,
                color: Colors.white,
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
                        Text("Chats", style: subTextStyle),
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
