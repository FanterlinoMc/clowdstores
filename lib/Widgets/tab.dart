import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../ui/WebUI/shopping_feed_web.dart';
import '../ui/WebUI/web_Profile.dart';
import '../ui/pages/more.dart';
import '../ui/pages/near_me_page.dart';
import '../ui/pages/search_page.dart';
import 'text-styles.dart';

class MyTab extends StatefulWidget {
  const MyTab({super.key});

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
    //  initialization();
  }

  // void initialization() async {
  //   FlutterNativeSplash.remove();
  // }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              //  SizedBox(height: 10),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: appBarColor, borderRadius: BorderRadius.circular(0)),
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
                        defaultValue: 13.0,
                        conditionalValues: [
                          const Condition.smallerThan(
                              name: DESKTOP, value: 10.0)
                        ],
                      ).value),
                    ),
                    Text(
                      "Search",
                      style: TextStyle(
                          fontSize: ResponsiveValue(
                        context,
                        defaultValue: 13.0,
                        conditionalValues: [
                          const Condition.smallerThan(
                              name: DESKTOP, value: 10.0)
                        ],
                      ).value),
                    ),
                    Text(
                      "Feed",
                      style: TextStyle(
                          fontSize: ResponsiveValue(
                        context,
                        defaultValue: 13.0,
                        conditionalValues: [
                          const Condition.smallerThan(
                              name: DESKTOP, value: 10.0)
                        ],
                      ).value),
                    ),
                    Text(
                      "NearMe",
                      style: TextStyle(
                          fontSize: ResponsiveValue(
                        context,
                        defaultValue: 13.0,
                        conditionalValues: [
                          const Condition.smallerThan(
                              name: DESKTOP, value: 10.0)
                        ],
                      ).value),
                    ),
                    Text(
                      "More",
                      style: TextStyle(
                          fontSize: ResponsiveValue(
                        context,
                        defaultValue: 13.0,
                        conditionalValues: [
                          const Condition.smallerThan(
                              name: DESKTOP, value: 10.0)
                        ],
                      ).value),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
                    WebProfile(),
                    SearchScreen(),
                    ShoppingFeedWeb(),
                    NearMe(),
                    More(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
