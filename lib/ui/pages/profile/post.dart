import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/text-styles.dart';
import '../../../helpers/streams_providers.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

// late VideoPlayerController _videoPlayerController;

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final store = ref.watch(getUserPost);
        return store.when(
          data: (QuerySnapshot value) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: size.height,
                width: 500,
                child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
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
                                    value.docs[index]["storeProfile"]),
                              ),
                              title: Column(
                                children: [
                                  Text(
                                    value.docs[index]["storeName"],
                                    style: const TextStyle(color: appBarColor),
                                  ),
                                  Text(value.docs[index]["postCategory"],
                                      style: const TextStyle(
                                          color: appBarColor, fontSize: 13)),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_horiz_outlined),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value.docs[index]["postContent"]),
                            ),
                            ExtendedImage.network(
                              value.docs[index]["postImage"],
                            ),
                            // value.docs[index]["isVideo"]
                            //     ? ExtendedImage.network(
                            //         value.docs[index]["videoUrl"],
                            //       )
                            //     : Center(
                            //         child: AspectRatio(
                            //             aspectRatio:
                            //                 _videoPlayerController
                            //                     .value.aspectRatio,
                            //             child: VideoPlayer(value
                            //                 .docs[index]["postImage"])
                            //             // VideoPlayer(
                            //             //   _controller =
                            //             //       VideoPlayerController
                            //             //           .networkUrl(
                            //             //     Uri.parse(value.docs[index]
                            //             //         ["postImage"]),
                            //             //   ),
                            //             // ),
                            //             ),
                            //       ),
                            // FloatingActionButton(
                            //   onPressed: () {
                            //     setState(() {
                            //       _controller.value.isPlaying
                            //           ? _controller.pause()
                            //           : _controller.play();
                            //     });
                            //   },
                            //   child: Icon(
                            //     _controller.value.isPlaying
                            //         ? Icons.pause
                            //         : Icons.play_arrow,
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            //!change the button functionality
                                            // cart.chnageProductName(value
                                            //     .docs[index]["name"]);
                                            // cart.chnageProductPrice(
                                            //     value.docs[index]
                                            //         ["price"]);

                                            // cart.chnageProductproductPhotoUrl(
                                            //     value.docs[index]
                                            //         ["photoUrl"]);
                                            // cart
                                            //     .chnageUserName(
                                            //       value.docs[index]
                                            //           ["storeName"],
                                            //     )
                                            //     .toString();
                                            // // cart.chnageStoreNumber(
                                            // //     value.docs[index]["storeNumber"]);
                                            // cart.chnagestoreId(
                                            //     value.docs[index]
                                            //         ["storeId"]);
                                            // cart.chnageProductId(
                                            //     value.docs[index]
                                            //         ["productId"]);
                                            // cart.chnageProductType(
                                            //     value.docs[index]
                                            //         ["productType"]);
                                            // cart.saveCart();
                                          },
                                          icon: const Icon(
                                            Icons.add_shopping_cart_outlined,
                                            size: 25,
                                          )),
                                      const Text("Add to Cart"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("shear"),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.share_outlined,
                                            size: 25,
                                          )),
                                    ],
                                  ),
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
