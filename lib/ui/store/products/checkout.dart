import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/button.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:clowdstores/helpers/streams_providers.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../Data/fire_store_streams.dart';
import '../../../Widgets/Froms/check_from.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ClowdSliverAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Consumer(
                  builder: (context, ref, child) {
                    final checkOut = ref.watch(getCheckOut);

                    final getproduct = ref.read(getProductDellivery);
                    return checkOut.when(
                        data: (QuerySnapshot value) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //alignment: WrapAlignment.start,
                                  children: [
                                    ExtendedImage.network(
                                      value.docs[index]["photoUrl"],
                                      height: 200,
                                      width: 210,
                                    ),
                                    Text(value.docs[index]['name'],
                                        style: textStyle),
                                    Text('${value.docs[index]['price']}EG',
                                        style: textStyle),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Add your shipping information"),
                              ),
                              const CheckFrom(),
                              CloudButton(
                                name: "CheckOut",
                                onPressed: () {
                                  getproduct
                                      .changeCity(value.docs[index]["city"]);
                                  getproduct.changeDescription(
                                      value.docs[index]["description"]);
                                  getproduct.changeLatitude(
                                      value.docs[index]["lattitude"]);
                                  getproduct.changeLongitude(
                                      value.docs[index]["longitude"]);
                                  getproduct
                                      .changeName(value.docs[index]["name"]);
                                  getproduct.changPhotoUrl(
                                      value.docs[index]["photoUrl"]);
                                  getproduct.changeProductId(
                                      value.docs[index]["productId"]);
                                  getproduct.changeProductType(
                                      value.docs[index]["productType"]);
                                  getproduct.changeStoreId(
                                      value.docs[index]["storeId"]);
                                  getproduct.changeStore(
                                      value.docs[index]["storeName"]);
                                  getproduct.changeStorephotoUrl(
                                      value.docs[index]["storephotoUrl"]);
                                  getproduct.changeUserAddrees("maadi");
                                  getproduct.changeUserLat(
                                      value.docs[index]["lattitude"]);
                                  getproduct.changeUserLgn(
                                      value.docs[index]['longitude']);
                                  getproduct.changeUserName("lino");
                                  getproduct.changeUserPhone("155034991");
                                  getproduct.changeOrderStatus("done");
                                  getproduct.changeOrderId("1");
                                  getproduct.changePickUp(true);
                                  getproduct.changeDropOff(true);
                                  getproduct.setDlivery();
                                  context.push('/');
                                  //TODO debug
                                },
                              ),
                            ],
                          );
                        },
                        error: (stack, error) {
                          return const Text("error");
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()));
                  },
                );

                // <Widget>[

                // ],
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
