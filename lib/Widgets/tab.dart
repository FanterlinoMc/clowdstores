import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:clowdstores/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../ui/WebUI/web_Profile.dart';
import '../ui/pages/more.dart';
import '../ui/pages/near_me_page.dart';
import '../ui/pages/search_page.dart';

class MyTab extends StatefulWidget {
  const MyTab({Key? key}) : super(key: key);

  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this, initialIndex: 2);
    //StoreProvider().getLocationPro();
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                //  SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: appBarColor,
                        borderRadius: BorderRadius.circular(0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: TabBar(
                            unselectedLabelColor: Colors.white,
                            labelColor: Colors.black,
                            indicatorColor: Colors.white,
                            indicatorWeight: 2,
                            indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            controller: tabController,
                            tabs: [
                              Text(
                                "Me",
                                style: TextStyle(
                                    fontSize: ResponsiveValue(
                                  context,
                                  defaultValue: 15.0,
                                  valueWhen: [
                                    const Condition.smallerThan(
                                        name: DESKTOP, value: 15.0)
                                  ],
                                ).value),
                              ),
                              Text(
                                "Search",
                                style: TextStyle(
                                    fontSize: ResponsiveValue(
                                  context,
                                  defaultValue: 15.0,
                                  valueWhen: [
                                    const Condition.smallerThan(
                                        name: DESKTOP, value: 15.0)
                                  ],
                                ).value),
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: ResponsiveValue(
                                  context,
                                  defaultValue: 15.0,
                                  valueWhen: [
                                    const Condition.smallerThan(
                                        name: DESKTOP, value: 15.0)
                                  ],
                                ).value),
                              ),
                              Text(
                                "NearMe",
                                style: TextStyle(
                                    fontSize: ResponsiveValue(
                                  context,
                                  defaultValue: 15.0,
                                  valueWhen: [
                                    const Condition.smallerThan(
                                        name: DESKTOP, value: 15.0)
                                  ],
                                ).value),
                              ),
                              Text(
                                "More",
                                style: TextStyle(
                                    fontSize: ResponsiveValue(
                                  context,
                                  defaultValue: 15.0,
                                  valueWhen: [
                                    const Condition.smallerThan(
                                        name: DESKTOP, value: 15.0)
                                  ],
                                ).value),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: const [
                      WebProfile(),
                      SearchScreen(),
                      Home(),
                      NearMe(),
                      More(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
