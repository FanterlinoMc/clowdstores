import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/change_notifiiers.dart';
import '../helpers/streams_providers.dart';

class ProDrop extends StatefulWidget {
  final String pro;
  const ProDrop({
    super.key,
    this.pro = "Selcet",
    //  required this.storeId,
  });

  @override
  State<ProDrop> createState() => _ProDropState();
}

class _ProDropState extends State<ProDrop> {
  dynamic selectedType;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        final productT = ref.watch(productRow);
        final productTypeChange = ref.read(productPro);
        return productT.when(
            data: (QuerySnapshot value) {
              List productTypeList = [
                value.docs[0]["productType0"],
                value.docs[0]["productType1"],
                value.docs[0]["productType2"],
              ];
              return Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 12, right: 12),
                child: Container(
                  height: 50,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blueGrey)),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    items: productTypeList
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Center(
                              child: Text(value),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (selectedtype) {
                      setState(() {
                        selectedType = selectedtype;
                        WriteCache.setString(
                            key: "proType", value: selectedType);
                        productTypeChange.changeProductType(selectedType);
                      });
                    },
                    value: selectedType,
                    hint: const Center(child: Text("Selcet Product Category")),
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (value, erorr) {
              return const Center(
                child: Text("Erorr"),
              );
            });
      }),
    );
  }
}
