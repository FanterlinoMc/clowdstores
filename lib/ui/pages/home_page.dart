import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer(
        builder: (context, ref, child) {
          final store = ref.watch(getStores);
          return store.when(
            data: (QuerySnapshot value) {
              if (!value.docs.isNotEmpty) {
                return const Center(child: Text("Sanmething went wrong "));
              }
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          child: ExtendedImage.network(
                            "https://firebasestorage.googleapis.com/v0/b/clowdstores-101.appspot.com/o/Stores%2FclowdStores%404x.png?alt=media&token=c7141a90-9568-4fc2-9416-12421bda7b67",
                            // storeModel.photoUrl ?? "No info",

                            shape: BoxShape.rectangle,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(0),

                            //  scale: 0.5,
                            enableMemoryCache: true,
                            //width: 300,
                            height: 300,
                          ),
                        ),
                        const HomeCard(),
                      ],
                    ),
                  )
                ],
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (value, stack) => const Center(child: Text("error")),
          );
        },
      ),
    );
  }
}

class HomeCard extends ConsumerWidget {
  const HomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerState);
    final liveLocaion = ref.read(storeProvider);

    return SizedBox(
      width: ResponsiveValue(context, defaultValue: 1000.0, valueWhen: [
        const Condition.smallerThan(
          name: DESKTOP,
          value: 300.0,
        ),
      ]).value,
      child: Column(
        children: [
          ResponsiveRowColumn(
            layout: ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Card(
                  shape: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      //  width: .5,
                    ),
                  ),
                  shadowColor: Colors.black87,
                  elevation: 5,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      context.go("/AddProduct");
                    },
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.pets_outlined,
                            color: Colors.tealAccent,
                          ),
                          Text("Pets", style: TextStyle(fontSize: 17)),
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
                      color: Colors.greenAccent,
                      // width: 2.5,
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
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.local_offer_outlined,
                            size: 20,
                            color: Colors.greenAccent,
                          ),
                          Text("Sales", style: TextStyle(fontSize: 17))
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
                    ),
                  ),
                  shadowColor: Colors.black87,
                  elevation: 5,
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    child: InkWell(
                      onTap: () {
                        router.chanageRandomString("Tech Stores");

                        router.routeSates();
                        context.push(
                          '/Categories',
                          extra: "Tech Stores",
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.phone_android_outlined,
                            size: 20,
                            color: Colors.blue,
                          ),
                          Text("TechStores", style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const ResponsiveRowColumnItem(
                  child: SizedBox(
                height: 20,
              )),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Card(
                  shape: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.orange,
                    // width: 2.5,
                  )),
                  shadowColor: Colors.black87,
                  elevation: 5,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () async {
                      router.chanageRandomString("Automtive");

                      router.routeSates();
                      context.push(
                        '/Categories',
                        extra: "Automtive",
                      );
                    },
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.car_repair,
                            size: 20,
                            color: Colors.orange,
                          ),
                          Text("Automtive", style: TextStyle(fontSize: 17))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.local_fire_department_outlined,
                            size: 20,
                            color: Colors.red,
                          ),
                          Text("Hot&New", style: TextStyle(fontSize: 17)),
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
                      color: Colors.pink,
                      // width: 2.5,
                    ),
                  ),
                  shadowColor: Colors.black87,
                  elevation: 5,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      router.chanageRandomString("Fashion");

                      router.routeSates();
                      context.push(
                        '/Categories',
                        //   extra: "Fashion",
                      );
                    },
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.shopping_basket_outlined,
                            size: 20,
                            color: Colors.pink,
                          ),
                          Text("Fashion", style: TextStyle(fontSize: 17))
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
                      color: Colors.cyan,
                      // width: 2.5,
                    ),
                  ),
                  shadowColor: Colors.black87,
                  elevation: 5,
                  color: Colors.white,
                  child: SizedBox(
                    height: 30,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const ComingSoon();
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.delivery_dining_outlined,
                            size: 20,
                            color: Colors.cyan,
                          ),
                          Text(
                            "Devlivery",
                            style: TextStyle(fontSize: 17),
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
                    color: Colors.amber,
                    // width: 2.5,
                  )),
                  shadowColor: Colors.black87,
                  elevation: 5,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () async {
                      router.chanageRandomString("Cinema");

                      router.routeSates();
                      context.push(
                        '/Categories',
                        extra: "Cinema",
                      );
                    },
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.local_movies_outlined,
                            size: 20,
                            color: Colors.amber,
                          ),
                          Text("Cinema", style: TextStyle(fontSize: 17)),
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
    );
  }
}
