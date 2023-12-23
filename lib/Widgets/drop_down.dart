import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../Data/fire_store_streams.dart';
import '../helpers/change_notifiiers.dart';
import '../helpers/streams_providers.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  dynamic selectedCateroy;
  final List<dynamic> _categoirseList = [
    "Active Life ",
    "Art & Enterainmet",
    "Beauty & Spa",
    "Cinema",
    "Event Palanning & Servicses",
    "Food",
    "Fashion",
    "Health & Medical",
    "Home Sevricses",
    "Hoteles & Travel",
    "Local & Falvor",
    "Pets",
    "shopping",
    "Tech Stores",
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Consumer(
        builder: (context, ref, child) {
          final store = ref.watch(storeNotifer);
          final router = ref.read(cacheState);
          return Container(
            width: constraints.maxWidth,
            height: 50,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueGrey)),
            child: Align(
              child: DropdownButton(
                //    dropdownColor: appBarColor,
                underline: const SizedBox(),
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                items: _categoirseList
                    .map(
                      (value) => DropdownMenuItem(
                        //   alignment: AlignmentDirectional.,
                        value: value,
                        //   alignment: AlignmentDirectional.,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (selectedCate) {
                  setState(() {
                    selectedCateroy = selectedCate;
                    store.changeCategorise(selectedCateroy);
                    router.chanageRouterId(selectedCateroy);
                    router.chanagesubRouterId(selectedCateroy);
                    router.routeSates();
                  });
                },
                value: selectedCateroy,
                hint: const Center(child: Text("Selcet a Category")),
              ),
            ),
          );
        },
      );
    });
  }
}

class MapListOption extends StatefulWidget {
  // final Function onPrees;
  const MapListOption({
    super.key,
    //  this.onPrees,
  });

  @override
  _MapListOption createState() => _MapListOption();
}

class _MapListOption extends State<MapListOption> {
  dynamic selectedCateroy;
  final List<dynamic> _categoirseList = [
    "Active Life ",
    "Art & Enterainmet",
    "Beauty & Spa",
    "Cinema",
    "Event Palanning & Servicses",
    "Food",
    "Fashion",
    "Health & Medical",
    "Home Sevricses",
    "Hoteles & Travel",
    "Local & Falvor",
    "Pets",
    "shopping",
    "Tech Stores",
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Consumer(
        builder: (context, ref, child) {
          //    final store = ref.watch(storeNotifer);
          final router = ref.read(cacheState);
          return AnimationLimiter(
            child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: _categoirseList.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      delay: const Duration(milliseconds: 200),
                      child: ScaleAnimation(
                        delay: const Duration(milliseconds: 100),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: appBarColor,
                                foregroundColor: Colors.white),
                            child: Text(
                              _categoirseList[index],
                              style: const TextStyle(fontSize: 17),
                            ),
                            onPressed: () {
                              router.chanageRandomMap(
                                _categoirseList[index],
                              );
                              router.routeSates();
                              return ref.refresh(storeMap);
                              //  WriteCache.setString(key: "randomMap");
                              // widget.onPrees;
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      );
    });
  }
}
