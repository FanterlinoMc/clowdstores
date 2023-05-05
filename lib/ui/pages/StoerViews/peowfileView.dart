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
import '../../../Widgets/coming_soon.dart';
import '../../../helpers/change_notifiiers.dart';
import '../../../helpers/streams_providers.dart';
import 'product_Row_View.dart';
import 'product_TextView.dart';

class ProfileView extends StatelessWidget {
  final String? storeIdProfile;

  const ProfileView({
    Key? key,
    this.storeIdProfile,
  }) : super(key: key);

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
                    child: SizedBox(
                      width: ResponsiveValue(context,
                          defaultValue: 700.0,
                          valueWhen: [
                            Condition.smallerThan(
                              name: DESKTOP,
                              value: size.width,
                            ),
                          ]).value,
                      child: CustomScrollView(
                        slivers: [
                          ClowdSliverAppBar(
                            title: Center(
                              child: Text(
                                value.docs[0]["businessName"],
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                //columnCount: value.docs.length,
                                child: ScaleAnimation(
                                  delay: const Duration(milliseconds: 200),
                                  // verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    delay: const Duration(milliseconds: 100),
                                    //  delay: Duration(seconds: 1),
                                    child: Column(
                                      children: [
                                        ExtendedImage.network(
                                          value.docs[index]["photoUrl"],
                                          shape: BoxShape.rectangle,
                                          fit: BoxFit.fitWidth,
                                          borderRadius: kIsWeb
                                              ? BorderRadius.circular(10)
                                              : BorderRadius.circular(0),
                                          height: ResponsiveValue(context,
                                              defaultValue: 220.0,
                                              valueWhen: [
                                                const Condition.smallerThan(
                                                  name: TABLET,
                                                  value: 300.0,
                                                ),
                                                const Condition.smallerThan(
                                                  name: DESKTOP,
                                                  value: 150.0,
                                                ),
                                              ]).value,
                                          width: ResponsiveValue(
                                            context,
                                            defaultValue: 400.0,
                                            valueWhen: [
                                              const Condition.smallerThan(
                                                name: TABLET,
                                                value: tW,
                                              ),
                                              const Condition.smallerThan(
                                                name: DESKTOP,
                                                value: mW,
                                              ),
                                            ],
                                          ).value,
                                          enableMemoryCache: true,
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
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "About",
                                              style: TextStyle(fontSize: 30),
                                            ),
                                            // Text(
                                            //     value.docs[index]
                                            //         ["businessEmail"],
                                            //     style: textStyle),
                                            Text(
                                                value.docs[index]["categories"],
                                                style: textStyle),
                                            Text(value.docs[index]["city"],
                                                style: textStyle),
                                            Row(
                                              children: [
                                                TextButton(
                                                  child: Text(
                                                    value.docs[index]
                                                        ["webAddress"],
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  onPressed: () {
                                                    launchUrl(Uri(
                                                      scheme: "https",
                                                      host: value.docs[index]
                                                          ["webAddress"],
                                                    ));
                                                  },
                                                )
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FloatingActionButton
                                                    .extended(
                                                  //   hoverColor: Colors.white,
                                                  backgroundColor: appBarColor,
                                                  onPressed: () {
                                                    clowdlink.changeUserId(
                                                      value.docs[index]
                                                          ["userId"],
                                                    );
                                                    clowdlink.changeDescription(
                                                      value.docs[index]
                                                          ["categories"],
                                                    );
                                                    clowdlink.changeImage(
                                                      value.docs[index]
                                                          ["photoUrl"],
                                                    );
                                                    clowdlink.changeTitle(
                                                      value.docs[index]
                                                          ["businessName"],
                                                    );
                                                    clowdlink.createStoreLink();
                                                  },
                                                  label: const Icon(
                                                      Icons.share_sharp),
                                                  //  icon: const Icon(Icons.location_on_outlined),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }, childCount: 1),
                          )
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
