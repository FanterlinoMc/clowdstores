import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/change_notifiiers.dart';

class HomeCard extends ConsumerWidget {
  const HomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerState);
    //  final liveLocaion = ref.read(storeProvider);

    return Column(
      children: [
        ResponsiveRowColumn(
          // rowCrossAxisAlignment: CrossAxisAlignment.center,
          rowMainAxisAlignment: MainAxisAlignment.center,
          layout: ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              // rowFlex: 1,
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
                  child: const SizedBox(
                    height: 30,
                    width: 100,
                    // width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.pets_outlined,
                          color: Colors.tealAccent,
                          size: 17,
                        ),
                        Text("Pets", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              // rowFit: FlexFit.tight,
              // rowFlex: 1,
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
                  child: const SizedBox(
                    height: 30,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          size: 17,
                          color: Colors.greenAccent,
                        ),
                        Text("Sales", style: TextStyle(fontSize: 14))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              // rowFlex: 1,
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
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      router.chanageRandomString("Tech Stores");

                      router.routeSates();
                      context.push(
                        '/Categories',
                        extra: "Tech Stores",
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.phone_android_outlined,
                          size: 17,
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
              height: 17,
            )),
            // ResponsiveRowColumnItem(
            //   // rowFlex: 1,
            //   child: Card(
            //     shape: const OutlineInputBorder(
            //         borderSide: BorderSide(
            //       color: Colors.orange,
            //       // width: 2.5,
            //     )),
            //     shadowColor: Colors.black87,
            //     elevation: 5,
            //     color: Colors.white,
            //     child: InkWell(
            //       onTap: () async {
            //         router.chanageRandomString("Automtive");

            //         router.routeSates();
            //         context.push(
            //           '/Categories',
            //           extra: "Automtive",
            //         );
            //       },
            //       child: const SizedBox(
            //         height: 30,
            //         width: 100,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             Icon(
            //               Icons.car_repair,
            //               size: 17,
            //               color: Colors.orange,
            //             ),
            //             Text("Automtive", style: TextStyle(fontSize: 14))
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.center,
          layout: ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              // rowFlex: 1,
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
                  child: const SizedBox(
                    height: 30,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.local_fire_department_outlined,
                          size: 17,
                          color: Colors.red,
                        ),
                        Text("Hot&New", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              // rowFlex: 1,
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
                  child: const SizedBox(
                    height: 30,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.shopping_basket_outlined,
                          size: 17,
                          color: Colors.pink,
                        ),
                        Text("Fashion", style: TextStyle(fontSize: 14))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ResponsiveRowColumnItem(
            //   // rowFlex: 1,
            //   child: Card(
            //     shape: const OutlineInputBorder(
            //       borderSide: BorderSide(
            //         color: Colors.cyan,
            //         // width: 2.5,
            //       ),
            //     ),
            //     shadowColor: Colors.black87,
            //     elevation: 5,
            //     color: Colors.white,
            //     child: SizedBox(
            //       height: 30,
            //       width: 100,
            //       child: InkWell(
            //         onTap: () {
            //           showDialog(
            //               context: context,
            //               builder: (context) {
            //                 return const ComingSoon();
            //               });
            //         },
            //         child: const Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             Icon(
            //               Icons.delivery_dining_outlined,
            //               size: 17,
            //               color: Colors.cyan,
            //             ),
            //             Text(
            //               "Devlivery",
            //               style: TextStyle(fontSize: 14),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            ResponsiveRowColumnItem(
              // rowFlex: 1,
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
                  child: const SizedBox(
                    height: 30,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.local_movies_outlined,
                          size: 17,
                          color: Colors.amber,
                        ),
                        Text("Cinema", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
