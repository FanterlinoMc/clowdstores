import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helpers/streams_providers.dart';
import 'home_page.dart';

class ShoppingFeed extends StatelessWidget {
  const ShoppingFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final store = ref.watch(getPost);
        return store.when(
          data: (QuerySnapshot value) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HomeCard(),
                    SizedBox(
                      height: size.height,
                      width: 450,
                      child: ListView.builder(
                        itemCount: value.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Card(
                              elevation: 10,
                              // color: Colors.blue,
                              // height: 200,
                              // width: 400,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          value.docs[index]["postImage"]),
                                    ),
                                    title: Align(
                                      alignment: Alignment.topLeft,
                                      child: TextButton(
                                        child: Text(
                                            value.docs[index]["postTitle"],
                                            style: const TextStyle(
                                                color: appBarColor)),
                                        onPressed: () {},
                                      ),
                                    ),
                                    subtitle:
                                        Text(value.docs[index]["postCate"]),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon:
                                          const Icon(Icons.more_horiz_outlined),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text(value.docs[index]["postContent"]),
                                  ),
                                  // Text(value.docs[index]["postContent"]),
                                  ExtendedImage.network(
                                    value.docs[index]["postImage"],

                                    // height: 300,
                                    // width: 300,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.shopping_cart,
                                              size: 30,
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.share_outlined,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          error: (value, stack) => const Center(child: Text("error")),
        );
      },
    );
  }
}
