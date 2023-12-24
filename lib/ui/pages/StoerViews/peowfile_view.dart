import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/helpers/responive.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/sizeBox.dart';
import '../../../Widgets/text-styles.dart';
import '../../../helpers/change_notifiiers.dart';
import '../../../helpers/streams_providers.dart';
import '../profile/post.dart';
import 'product_Row_View.dart';
import 'product_TextView.dart';

class ProfileView extends StatelessWidget {
  final String? storeIdProfile;

  const ProfileView({
    super.key,
    this.storeIdProfile,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        body: Consumer(
          builder: (context, ref, child) {
            // final storepro = ref(storeNotifer);
            final store = ref.watch(getStoreView);
            final clowdlink = ref.read(clowdLink);

            return store.when(
              data: (QuerySnapshot value) {
                return AnimationLimiter(
                  child: Center(
                    child: WebSizeBox(
                      child: CustomScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            collapsedHeight: 200,
                            pinned: true,
                            expandedHeight: size.height,
                            backgroundColor: Colors.white,
                            flexibleSpace: ListView.builder(
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.docs.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    //columnCount: value.docs.length,
                                    child: ScaleAnimation(
                                      delay: const Duration(milliseconds: 200),
                                      // verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        delay:
                                            const Duration(milliseconds: 100),
                                        //  delay: Duration(seconds: 1),
                                        child: Column(
                                          children: [
                                            ImageSizeBox(
                                              child: ExtendedImage.network(
                                                value.docs[index]["photoUrl"],
                                                shape: BoxShape.rectangle,
                                                fit: BoxFit.fitWidth,
                                                borderRadius: kIsWeb
                                                    ? BorderRadius.circular(10)
                                                    : BorderRadius.circular(0),
                                                enableMemoryCache: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextProRowView(
                                                searchInfo: value.docs[index]),
                                            const ProductRowView(),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "About",
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                      value.docs[index]
                                                          ["categories"],
                                                      style: textStyle),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                      value.docs[index]["city"],
                                                      style: textStyle),
                                                  const SizedBox(height: 5),
                                                  InkWell(
                                                    focusColor: Colors.blue,
                                                    child: Text(
                                                      value.docs[index]
                                                          ["webAddress"],
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    onTap: () {
                                                      launchUrl(Uri(
                                                        scheme: "https",
                                                        host: value.docs[index]
                                                            ["webAddress"],
                                                      ));
                                                    },
                                                  ),
                                                  const SizedBox(height: 5),
                                                  kIsWeb
                                                      ? const SizedBox.shrink()
                                                      : Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                FloatingActionButton
                                                                    .extended(
                                                              //   hoverColor: Colors.white,
                                                              backgroundColor:
                                                                  appBarColor,
                                                              onPressed: () {
                                                                clowdlink
                                                                    .changeUserId(
                                                                  value.docs[
                                                                          index]
                                                                      [
                                                                      "userId"],
                                                                );
                                                                clowdlink
                                                                    .changeDescription(
                                                                  value.docs[
                                                                          index]
                                                                      [
                                                                      "categories"],
                                                                );
                                                                clowdlink
                                                                    .changeImage(
                                                                  value.docs[
                                                                          index]
                                                                      [
                                                                      "photoUrl"],
                                                                );
                                                                clowdlink
                                                                    .changeTitle(
                                                                  value.docs[
                                                                          index]
                                                                      [
                                                                      "businessName"],
                                                                );
                                                                clowdlink
                                                                    .createStoreLink();
                                                              },
                                                              label: const Icon(
                                                                Icons
                                                                    .share_sharp,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              //  icon: const Icon(Icons.location_on_outlined),
                                                            ),
                                                          ),
                                                        ),
                                                  const Post()
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          // ClowdSliverAppBar(

                          // SliverList(
                          //     delegate: SliverChildListDelegate(
                          //         <Widget>[const Post()]))
                        ],
                      ),
                    ),
                  ),
                );
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              error: (val, stack) => const Center(child: Text("erorr")),
            );
          },
        ),
      );
    });
  }
}