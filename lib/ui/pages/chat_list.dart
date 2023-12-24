import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../Data/fire_store_streams.dart';
import '../../Widgets/text-styles.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class ChatList extends StatelessWidget {
  final dynamic senderInfo;
  const ChatList({Key? key, this.senderInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(builder: (context, ref, child) {
        final chat = ref.watch(messageList);
        final route = ref.read(cacheState);
        //    final cha = ref(messageLis);
        return chat.when(data: (QuerySnapshot value) {
          return CustomScrollView(
            slivers: [
              ClowdSliverAppBar(
                title: const Text(
                  "Chat List",
                  style: TextStyle(color: appBarColor),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      onTap: () async {
                        route.chanageRoomId(value.docs[index]["roomId"]);
                        route.chanageName(value.docs[index]["name"]);

                        // route.chanagePhotoUrl(value.docs[index]["photoUrl"]);

                        route.chanageSenderId(value.docs[index]["senderId"]);
                        route.chanageIsMe(value.docs[index]["isMe"]);
                        route.chanageUserId(value.docs[index]["userId"]);
                        route.routeSates();
                        context.go(
                          "/ChatPage",
                        );
                      },
                      leading: CircleAvatar(
                        maxRadius: 20,
                        minRadius: 15,
                        backgroundImage: NetworkImage(
                          value.docs[index]["isMe"]
                              ? value.docs[index]["photoUrl"]
                              : value.docs[index]["photoUrl"],
                          // value.docs[index]["storePhotoUrl"],
                        ),
                      ),
                      title: Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      value.docs[index]["isMe"]
                                          ? value.docs[index]["name"]
                                          : value.docs[index]["name"],
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        value.docs[index]["message"],
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: value.docs.length,
                ),
              ),
            ],
          );
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }, error: (value, stack) {
          return const Center(
            child: Text("Erorr"),
          );
        });
      }),
    );
  }
}
