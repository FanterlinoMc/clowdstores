import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/Widgets/button.dart';
import 'package:clowdstores/Widgets/coming_soon.dart';
import 'package:clowdstores/Widgets/sizeBox.dart';
import 'package:clowdstores/helpers/streams_providers.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Widgets/Froms/check_from.dart';
import '../../../Widgets/text-styles.dart';
import '../../../helpers/change_notifiiers.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    //todo fix the size of the product Image
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
                    final getDelivery = ref.read(getDellivery);
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
                                    ImageSizeBox(
                                      child: ExtendedImage.network(
                                        value.docs[index]["photoUrl"],
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(value.docs[index]['name'], style: textStyle),
                              Text('${value.docs[index]['price']}EG',
                                  style: textStyle),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Add your shipping information"),
                              ),
                              const CheckFrom(),
                              CloudButton(
                                name: "CheckOut",
                                onPressed: () {
                                  // getDelliver,
                                  getDelivery.changeCity(
                                    value.docs[index]["city"],
                                  );
                                  getDelivery.changPhotoUrl(
                                    value.docs[index]["photoUrl"],
                                  );
                                  getDelivery.changeDescription(
                                    value.docs[index]["description"],
                                  );
                                  getDelivery.changeLatitude(
                                    value.docs[index]["lattitude"],
                                  );
                                  getDelivery.changeLongitude(
                                    value.docs[index]["longitude"],
                                  );
                                  getDelivery.changeName(
                                    value.docs[index]["name"],
                                  );
                                  getDelivery.changeOrderId("order");
                                  getDelivery.changePrice(
                                    value.docs[index]["price"].toString(),
                                  );
                                  getDelivery.changeProductId(
                                    value.docs[index]["productId"],
                                  );
                                  getDelivery.changeProductType(
                                    value.docs[index]["productType"],
                                  );
                                  getDelivery.changeStoreId(
                                    value.docs[index]["storeId"],
                                  );
                                  getDelivery.changeStore(
                                    value.docs[index]["storeName"],
                                  );
                                  getDelivery.changeStorephotoUrl(
                                    value.docs[index]["storephotoUrl"],
                                  );
                                  getDelivery.changeUserAddrees("userAddrees");
                                  getDelivery.changeUserLat(232323);
                                  getDelivery.changeUserLgn(121233);
                                  getDelivery.changeUserName("Wain");
                                  getDelivery.changeUserPhone("Wain");
                                  getDelivery.changeDropOff(false);
                                  getDelivery.changePickUp(false);
                                  getDelivery.changeOrderStatus("false");
                                  getDelivery
                                      .changeOrderId("afadfsdfjsdflsdfj");
                                  getDelivery.setDlivery();
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
