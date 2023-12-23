import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Data/fire_store_streams.dart';
import '../../helpers/change_notifiiers.dart';
import '../store/products/product_suggestion.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Stream<QuerySnapshot>? _product;
  final TextEditingController _searchController = TextEditingController();

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _product = null;
    });
  }

  // goNext(DocumentSnapshot pro) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => (DetaliPage(product: pro)),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // leading: kIsWeb ? SizedBox.shrink() : BackButton(color: appBarColor),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // // centerTitle: true,
        // elevation: 0.5,
        leadingWidth: size.width,
        toolbarHeight: 50,

        leading: TextField(
          cursorColor: appBarColor,
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            hintText: 'Search Products...',
            hintStyle: const TextStyle(
              color: appBarColor,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: appBarColor),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: appBarColor),
            ),
            prefixIcon: (const Icon(
              Icons.search_outlined,
              color: appBarColor,
            )),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: appBarColor,
              ),
              onPressed: () {
                clearSearch();
              },
            ),
            filled: true,
          ),
          onChanged: (input) {
            if (input.isNotEmpty) {
              setState(() {
                //    _users = FirestoreService.searchUsers(input);
                _product = CloudStreams.searchProduct(input);
              });
            }
          },
        ),
      ),
      body: _product == null
          ? ListView(
              children: [
                SizedBox(
                  width: 150,
                  height: ResponsiveValue(context,
                      defaultValue: 370.0,
                      conditionalValues: [
                        Condition.smallerThan(name: TABLET, value: 440.0),
                      ]).value,
                  child: const ProductSuggestion(),
                ),
              ],
            )
          : Consumer(
              builder: (context, ref, child) {
                final router = ref.read(cacheState);
                return StreamBuilder(
                  stream: _product,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data.docs.length == 0) {
                      return const Center(
                        child: Text('No users found!'),
                      );
                    }

                    return CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext contexr, int index) {
                              return Card(
                                color: Colors.white,
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                shadowColor: appBarColor,
                                //    elevation: 5,
                                child: ListTile(
                                  onTap: () {
                                    router.chanageCollectionName(
                                        snapshot.data.docs[index]["storeId"]);
                                    router.chanageDocId(
                                        snapshot.data.docs[index]["productId"]);
                                    router.routeSates();

                                    context.push(
                                      '/DetaliPage',
                                      //extra: value.docs[index],
                                    );
                                    //  routerState.chanageRouterSate(snapshot.data);

                                    // goNext(snapshot.data.docs[index]);
                                  },
                                  title:
                                      Text(snapshot.data.docs[index]["name"]),
                                  leading: ExtendedImage.network(
                                    (snapshot.data.docs[index]["photoUrl"]),
                                    height: 100,
                                    width: 100,
                                    enableMemoryCache: true,
                                    fit: BoxFit.contain,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            (snapshot.data.docs[index]["price"])
                                                .toString(),
                                          ),
                                          Text(
                                            (snapshot.data.docs[index]
                                                    ["storeName"] ??
                                                const Text(
                                                    " category not found ")),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: snapshot.data.docs.length,
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
