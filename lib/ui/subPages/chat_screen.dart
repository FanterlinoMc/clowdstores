import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Data/fire_store_streams.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text-styles.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class ChatPage extends StatelessWidget {
  final dynamic messages;
  // final dynamic senderInfo;
  // final dynamic storeinfo;

  const ChatPage({
    Key? key,
    this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget messagesList(
      String message,
      bool isMe,
    ) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      bottomRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(10),
                      topRight: const Radius.circular(10),
                      bottomLeft: isMe
                          ? const Radius.circular(10)
                          : const Radius.circular(0),
                    ),
                    color: isMe ? appBarColor : Colors.blue,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    message,
                    style: rowStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget chatessages() {
      return Consumer(
        builder: (context, ref, child) {
          final chat = ref.watch(getMessages);

          return chat.when(
            data: (QuerySnapshot value) {
              if (value.docs.isEmpty) {
                return const Center(child: Text("Send your frist message"));
              } else {
                return CustomScrollView(
                  reverse: true,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return messagesList(
                            value.docs[index]["message"],
                            value.docs[index]['isMe'],
                            //widget.senderInfo!['photoUrl']
                            //  value.docs[index]["photoUrl"],
                          );
                        },
                        childCount: value.docs.length,
                      ),
                    )
                  ],
                );
              }
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (value, stack) => Center(
                child: CloudButton(
              name: "refresh",
              onPressed: () {
                return ref.refresh(getMessages);
              },
            )),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kIsWeb ? Colors.white : appBarColor,
          title: const Text(""),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            // final route = ref(routerState);
/* ? flutter no */
            // final fcm = ref(fcmNotifer);
            // final chat = ref(mList);
            final messagePro = ref.watch(sendMessageNotifer);

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: chatessages(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //  _chatessages(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) =>
                                  messagePro.changeMessage(value),
                              controller: _addMessage,
                            ),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.send_outlined),
                            onPressed: () async {
                              messagePro.changeName(
                                  await ReadCache.getString(key: "name"));

                              messagePro.ifIsMe(
                                value:
                                    await ReadCache.getString(key: "senderId"),
                              );

                              messagePro.updateRoom(
                                updateMessage: _addMessage.text,
                                updateUserId:
                                    await ReadCache.getString(key: "senderId"),
                                updateSenderId:
                                    await ReadCache.getString(key: "userId"),
                                updateRoomId:
                                    await ReadCache.getString(key: "roomId"),
                              );
                              messagePro.ChatRoom(
                                  isMe: await ReadCache.getBool(key: "isMe"),
                                  roomId:
                                      await ReadCache.getString(key: "roomId"));

                              _addMessage.clear();
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}

final TextEditingController _addMessage = TextEditingController();
