import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../Widgets/coming_soon.dart';
import '../../helpers/change_notifiiers.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          ClowdSliverAppBar(
            title: const Text(
              "Categories",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const MoreColumn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoreColumn extends StatelessWidget {
  const MoreColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final router = ref.read(cacheState);
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            // shadowColor: Colors.blueGrey,
            shape: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.brown),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.local_activity_outlined,
                color: Colors.brown,
              ),
              title: const Text(
                "Active Life",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Active Life");
                router.routeSates();
                context.push(
                  '/Privacy',
                );
                // context.push(
                //   '/Categories',
                // );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            child: ListTile(
              leading: const Icon(
                Icons.music_note,
                color: Colors.red,
              ),
              title: const Text(
                "Art & Enteraimet",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString(
                    "Art & Enteraim  router.routeSates();et");
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple)),
            // shadowColor: Colors.purple,
            // shape: OutlineInputBorder(),
            child: ListTile(
              leading: const Icon(
                Icons.brush_outlined,
                color: Colors.purple,
              ),
              title: const Text(
                "Bauty & Spas",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Bauty & Spas");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            child: ListTile(
              leading: const Icon(
                Icons.local_movies_outlined,
                color: Colors.black,
              ),
              title: const Text(
                "Cinema",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Cinema");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            child: ListTile(
              leading: const Icon(
                Icons.event,
                color: Colors.blue,
              ),
              title: const Text(
                "Event Planning & services",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Event Planning & services");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)),
            child: ListTile(
              leading: const Icon(
                Icons.restaurant_menu_outlined,
                color: Colors.orange,
              ),
              title: const Text(
                "Restaurant",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Restaurant");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green)),
            child: ListTile(
              leading: const Icon(
                Icons.checkroom_sharp,
                color: Colors.green,
              ),
              title: const Text(
                "Fsshion",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Fashion");

                router.routeSates();
                context.push(
                  '/Categories',
                  // extra: "Fashion",
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey)),
            child: ListTile(
              leading: const Icon(
                Icons.local_hospital_outlined,
                color: Colors.blueGrey,
              ),
              title: const Text(
                "Health & Mecical",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Health & Mecic");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent)),
            child: ListTile(
              leading: const Icon(
                Icons.home_repair_service_outlined,
                color: Colors.cyanAccent,
              ),
              title: const Text(
                "Home Riper & Services",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Home Riper & Services");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)),
            child: ListTile(
              leading: const Icon(
                Icons.hotel_outlined,
                color: Colors.teal,
              ),
              title: const Text(
                "Hotel & Travel",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Hotel & Travel");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow)),
            child: ListTile(
              leading: const Icon(
                Icons.local_cafe_outlined,
                color: Colors.yellow,
              ),
              title: const Text(
                "Local Flavor",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Local Flavor");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.pets_outlined,
                color: Colors.tealAccent,
              ),
              title: const Text(
                "Pets",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Pets");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
          Card(
            shape: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigoAccent)),
            child: ListTile(
              leading: const Icon(
                Icons.phone_android_sharp,
                color: Colors.indigoAccent,
              ),
              title: const Text(
                "Tech Stores",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              onTap: () {
                router.chanageRandomString("Tech Stores");
                router.routeSates();
                context.push(
                  '/Categories',
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
