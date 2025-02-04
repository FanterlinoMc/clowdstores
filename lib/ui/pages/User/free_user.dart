import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Data/sign_In_google.dart';
import '../../../Widgets/text-styles.dart';
import '../../../helpers/responive.dart';
import '../../../helpers/streams_providers.dart';
import '../welcome_page.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    final googleUser = SignInWithGoogle();

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Consumer(builder: (context, ref, child) {
        final user = ref.watch(getUsers);
        return user.when(
          data: (DocumentSnapshot value) {
            IconButton(
                icon: const Icon(
                  Icons.logout_outlined,
                  color: appBarColor,
                ),
                onPressed: () {
                  googleUser.signOut();
                  context.go("/");
                  return ref.refresh(authStateStraem);
                });
            if (value.exists) {
              return CustomScrollView(slivers: [
                SliverAppBar(
                  leading: const SizedBox.shrink(),
                  backgroundColor: kIsWeb ? Colors.white : appBarColor,
                  floating: true,
                  elevation: 2,
                  stretch: true,
                  actions: <Widget>[
                    IconButton(
                        icon: const Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          googleUser.signOut();
                          context.go("/");
                          return ref.refresh(authStateStraem);
                        }),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SizedBox(
                        width: ResponsiveValue(context,
                            defaultValue: 700.0,
                            conditionalValues: [
                              const Condition.smallerThan(
                                name: TABLET,
                                value: tW,
                              ),
                              const Condition.smallerThan(
                                name: DESKTOP,
                                value: mW,
                              ),
                            ]).value,
                        child: Column(
                          children: [
                            ResponsiveRowColumnItem(
                              child: ExtendedImage.network(
                                value["photoUrl"],
                                // storeModel.photoUrl ?? "No info",

                                shape: BoxShape.rectangle,
                                fit: BoxFit.fill,
                                borderRadius: BorderRadius.circular(20),

                                height: height / 5,
                                // width: width * 1,
                              ),
                            ),
                            //    const Icon(Icons.person_rounded, size: 30),
                            ResponsiveRowColumnItem(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      value["userName"],
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),

                                  // const Icon(Icons.email_rounded,
                                  //     size: 30, color: Colors.blue),
                                  Text(
                                    value["email"],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            ResponsiveRowColumn(
                              layout: ResponsiveRowColumnType.ROW,
                              children: [
                                ResponsiveRowColumnItem(
                                  rowFlex: 1,
                                  child: Card(
                                    shape: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        //  width: .5,
                                      ),
                                    ),
                                    shadowColor: Colors.black87,
                                    elevation: 2,
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const ComingSoon();
                                            });
                                      },
                                      child: const SizedBox(
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                                Icons.favorite_outline_outlined,
                                                size: 15,
                                                color: Colors.red),
                                            Text("favorite",
                                                style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ResponsiveRowColumnItem(
                                  rowFlex: 1,
                                  child: Card(
                                    shape: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.indigo,
                                        // width: 2.5,
                                      ),
                                    ),
                                    shadowColor: Colors.black87,
                                    elevation: 2,
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const ComingSoon();
                                            });
                                      },
                                      child: const SizedBox(
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.outbound_sharp,
                                                size: 15, color: Colors.indigo),
                                            Text(
                                              "Orders",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ResponsiveRowColumnItem(
                                  rowFlex: 1,
                                  child: Card(
                                    shape: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.orange,
                                        // width: 2.5,
                                      ),
                                    ),
                                    shadowColor: Colors.black87,
                                    elevation: 2,
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: 30,
                                      child: InkWell(
                                        onTap: () {
                                          context.push("/CartPage");
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons
                                                  .shopping_cart_checkout_outlined,
                                              size: 15,
                                              color: Colors.orange,
                                            ),
                                            Text("Cart",
                                                style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ResponsiveRowColumnItem(
                                  rowFlex: 1,
                                  child: Card(
                                    shape: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.blue,
                                      // width: 2.5,
                                    )),
                                    shadowColor: Colors.black87,
                                    elevation: 2,
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () async {
                                        context.go("/ChatList");
                                      },
                                      child: const SizedBox(
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.message_outlined,
                                                size: 15, color: Colors.blue),
                                            Text("Chats",
                                                style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
            } else {
              {
                return const OpeningView();
              }
            }
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (val, stack) => const Center(
            child: Text("Pls Logging to the app"),
          ),
        );
      }),
    );
  }
}
