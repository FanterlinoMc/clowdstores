import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clowdstores/ui/WebUI/web_Profile.dart';
import 'package:clowdstores/ui/pages/shopping_feed.dart';

import 'package:flutter/material.dart';

import '../Data/fire_store_streams.dart';
import '../providers/deep_link.dart';
import '../ui/pages/more.dart';
import '../ui/pages/near_me_page.dart';
import '../ui/pages/search_page.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({
    Key? key,
  }) : super(key: key);

  @override
  _NaviBarState createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  @override
  void initState() {
    ClowdLink().initalDynamic(context);
    super.initState();
  }

  int _selectedPage = 2;
  List<Widget> pageView = [
    const WebProfile(),
    const SearchScreen(),
    const ShoppingFeed(),
    const NearMe(),
    const More(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageView.elementAt(_selectedPage),
      bottomNavigationBar: BottomNavyBar(
          backgroundColor: Colors.white,
          curve: Curves.linear,
          animationDuration: const Duration(milliseconds: 300),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.account_circle_outlined,
                  color: appBarColor, size: 25),
              title: const Text("Me"),
              activeColor: appBarColor,
            ),
            BottomNavyBarItem(
                icon: const Icon(Icons.search_outlined,
                    color: appBarColor, size: 25),
                title: const Text("Search"),
                activeColor: appBarColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.home, color: appBarColor, size: 25),
                title: const Text("Shopping"),
                activeColor: appBarColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.near_me_outlined,
                    color: appBarColor, size: 25),
                title: const Text("Near Me"),
                activeColor: appBarColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.menu_outlined,
                    color: appBarColor, size: 25),
                title: const Text("More"),
                activeColor: appBarColor),
          ],
          selectedIndex: _selectedPage,
          onItemSelected: (index) {
            setState(() {
              _selectedPage = index;
            });
          }),
    );
  }
}
