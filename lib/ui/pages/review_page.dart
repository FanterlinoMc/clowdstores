import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Data/fire_store_streams.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class ReviewPage extends StatelessWidget {
  final dynamic storeInfo;
  ReviewPage({
    Key? key,
    required this.storeInfo,
  }) : super(key: key);

  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kIsWeb
            ? const SizedBox.shrink()
            : const BackButton(color: appBarColor),
        backgroundColor: const Color(0xFF082032),
      ),
      body: Consumer(builder: (context, ref, child) {
        final review = ref.read(addReview);
        final fireReview = ref.watch(reviewstream);
        return fireReview.when(
          data: (QuerySnapshot value) {
            if (value.docs.isNotEmpty) {
              return Stack(
                children: [
                  ListView.builder(
                      itemCount: value.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 60, top: 7),
                          // margin: EdgeInsets.symmetric(horizontal: 40, vertical: 4),
                          decoration: BoxDecoration(
                            color: appBarColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          value.docs[index]["userPic"] ??
                                              "no Info to show"),
                                    ),
                                  ),
                                  Text(
                                    value.docs[index]["nmae"] ??
                                        "No User Name to show",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value.docs[index]["review"] ?? "No Review ",
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                controller: _name,
                                onChanged: (value) =>
                                    review.changeReview(value),
                                decoration: InputDecoration(
                                  hintText: "write your review",
                                  hintStyle:
                                      const TextStyle(color: appBarColor),
                                  focusColor: Colors.blueGrey,
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.send_outlined),
                              onPressed: () async {
                                _name.clear();
                                review.changeStoerId(await ReadCache.getString(
                                    key: "randomString"));
                                review.saveReview(await ReadCache.getString(
                                    key: "randomString"));
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: _name,
                            onChanged: (value) => review.changeReview(value),
                            decoration: InputDecoration(
                              hintText: "write your review",
                              hintStyle: const TextStyle(color: Colors.blue),
                              focusColor: Colors.blueGrey,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send_outlined),
                        onPressed: () async {
                          _name.clear();
                          review.changeStoerId(
                              await ReadCache.getString(key: "randomString"));
                          review.saveReview(
                              await ReadCache.getString(key: "randomString"));
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          error: (value, stack) => Center(
            child: Text("$stack"),
          ),
        );
      }),
    );
  }
}
