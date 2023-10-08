import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/Froms/add_business_from.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/coming_soon.dart';
import '../../../helpers/change_notifiiers.dart';
import '../../../helpers/streams_providers.dart';
import '../../../providers/deep_link.dart';
import 'post.dart';
import 'product_row.dart';
import 'profile_textrow.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    ClowdLink().initalDynamic(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer(
          builder: (context, ref, child) {
            final clowdlink = ref.read(clowdLink);
            final store = ref.watch(getStore);
            final cachwRoute = ref.read(cacheState);

            return store.when(
              data: (QuerySnapshot value) {
                if (value.docs.isNotEmpty) {
                  return AnimationLimiter(
                    child: Center(
                      child: CustomScrollView(
                        slivers: [
                          ClowdSliverAppBar(
                            title: Text(value.docs[0]["businessName"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: "Roboto")),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                //columnCount: value.docs.length,
                                child: ScaleAnimation(
                                  // delay: Duration(milliseconds: 200),
                                  // verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    //  delay: Duration(milliseconds: 100),
                                    //  delay: Duration(seconds: 1),
                                    child: Column(
                                      children: [
                                        ExtendedImage.network(
                                          value.docs[index]["photoUrl"],
                                          shape: BoxShape.rectangle,
                                          fit: BoxFit.fitWidth,
                                          borderRadius: kIsWeb
                                              ? BorderRadius.circular(0)
                                              : BorderRadius.circular(0),
                                          height: ResponsiveValue(context,
                                              defaultValue: 220.0,
                                              conditionalValues: [
                                                Condition.smallerThan(
                                                    name: TABLET,
                                                    value: size.height / 3),
                                              ]).value,
                                          width: ResponsiveValue(
                                            context,
                                            defaultValue: 400.0,
                                            conditionalValues: [
                                              Condition.smallerThan(
                                                  name: TABLET,
                                                  value: size.width),
                                            ],
                                          ).value,
                                          enableMemoryCache: true,
                                        ),
                                        const SizedBox(height: 13),
                                        TextProRow(
                                            searchInfo: value.docs[index]),
                                        const SizedBox(height: 6),
                                        const ProductRow(),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "About",
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              const SizedBox(height: 5),
                                              const SizedBox(height: 5),
                                              Text(
                                                  value.docs[index]
                                                      ["categories"],
                                                  style: textStyle),
                                              const SizedBox(height: 5),
                                              Text(value.docs[index]["city"],
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
                                              Center(
                                                child: CloudButton(
                                                  name: "DashBrod",
                                                  onPressed: () async {
                                                    cachwRoute.chanagePhotoUrl(
                                                      value.docs[index]
                                                          ["photoUrl"],
                                                    );

                                                    cachwRoute.chanagecity(
                                                      value.docs[index]["city"],
                                                    );
                                                    cachwRoute.chanageRouterId(
                                                      value.docs[index]
                                                          ["categories"],
                                                    );
                                                    cachwRoute.chanageName(
                                                      value.docs[index]
                                                          ["businessName"],
                                                    );
                                                    cachwRoute.chanageLat(
                                                      value.docs[index]
                                                          ["latitude"],
                                                    );
                                                    cachwRoute.chanageLng(
                                                      value.docs[index]
                                                          ["longitude"],
                                                    );
                                                    cachwRoute.routeSates();
                                                    context.push('/DashBrod',
                                                        extra:
                                                            value.docs[index]);
                                                  },
                                                ),
                                              ),
                                              kIsWeb
                                                  ? const SizedBox.shrink()
                                                  : FloatingActionButton
                                                      .extended(
                                                      //   hoverColor: Colors.white,
                                                      backgroundColor:
                                                          appBarColor,
                                                      onPressed: () {
                                                        clowdlink.changeUserId(
                                                          value.docs[index]
                                                              ["userId"],
                                                        );
                                                        clowdlink
                                                            .changeDescription(
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
                                                        clowdlink
                                                            .createStoreLink();
                                                      },
                                                      label: const Icon(
                                                          Icons.share_sharp),
                                                      //  icon: const Icon(Icons.location_on_outlined),
                                                    ),
                                              const Post(),
                                            ],
                                          ),
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
                  );
                } else {
                  return const AddBusiness();
                }
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              error: (val, stack) => const Center(child: Text("Profile Error")),
            );
          },
        ),
      );
    });
  }
}
