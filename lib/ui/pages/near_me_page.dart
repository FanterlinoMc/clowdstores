import 'dart:async';

import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Data/fire_store_streams.dart';
import '../../Widgets/drop_down.dart';
import '../../helpers/streams_providers.dart';
import '../../providers/store_porvider.dart';

class NearMe extends StatefulWidget {
  const NearMe({super.key});

  @override
  _NearMeState createState() => _NearMeState();
}

final markers = <MarkerId, Marker>{};

class _NearMeState extends State<NearMe> {
  List<Marker> allMarkers = [];
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      //  _product = null;
    });
  }

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  void addMarker() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(30, 30)),
            "assets/clowdstores.ico")
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  _storeLocation() async {
    double lat = await ReadCache.getDouble(key: "lat");
    double lng = await ReadCache.getDouble(key: "lng");
    return CameraPosition(
      target: LatLng(
        lat,
        lng,
      ),
      //LatLng(liveLocaion.liveLtitude, liveLocaion.liveLongitude),
      tilt: 20,
      bearing: 20,
      zoom: 14.4746,
    );
  }

  Future<void> _insitStoreLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(_storeLocation()));
  }

  @override
  void initState() {
    addMarker();
    _insitStoreLocation();
    StoreProvider().getLocationPro();

    super.initState();
  }

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
                //  _product = CloudStreams.searchProduct(input);
              });
            }
          },
        ),
      ),
      body: mapConsumer(),
    );
  }

  Consumer mapConsumer() {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final storesMap = ref.watch(storeMap);
        //  final storePro = ref(storeProvider);
        final router = ref.read(cacheState);
        final liveLocaion = ref.read(storeProvider);

        return storesMap.when(
          data: (QuerySnapshot value) {
            Iterable markers =
                Iterable.generate(value.docs.toList().length, (index) {
              return Marker(
                icon: markerIcon,
                markerId: MarkerId(value.docs[index]['userId']),
                position: LatLng(
                  value.docs[index]['latitude'],
                  value.docs[index]['longitude'],
                ),
                onTap: () {
                  router.chanageRandomString(value.docs[index]['userId']);
                  router.routeSates();
                  context.go("/ProfileView");

                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) => Dialog(
                  //     // alignment: Alignment.topLeft,
                  //     child: SizedBox(
                  //       height: size.height / 1,
                  //       width: size.width,
                  //       child: const ProfileView(),
                  //     ),
                  //   ),
                  // );
                },
                infoWindow: InfoWindow(
                  title: value.docs[index]["businessName"],
                ),
              );
            });

            return Stack(
              children: [
                googelM(value, markers),
                SizedBox(
                  width: size.width,
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      //  SizedBox(width: 600, height: 40, child: MapListOption()),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: size.width,
                            height: 50,
                            child: const MapListOption()),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 80,
                        width: size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 170,
                                  width: 200,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      onTap: () async {
                                        CameraPosition storeLocation =
                                            CameraPosition(
                                          target: LatLng(
                                            value.docs[index]['latitude'],
                                            //   lat,
                                            value.docs[index]['longitude'],
                                            //  lng,
                                          ),
                                          //LatLng(liveLocaion.liveLtitude, liveLocaion.liveLongitude),
                                          tilt: 45,
                                          bearing: 90,
                                          zoom: 20,
                                        );
                                        final GoogleMapController controller =
                                            await _controller.future;

                                        controller.moveCamera(
                                          CameraUpdate.newCameraPosition(
                                              storeLocation),
                                        );
                                        router.chanageRandomString(
                                            value.docs[index]['userId']);
                                        router.routeSates();
                                        context.push("/ProfileView");

                                        // showDialog(
                                        //   context: context,
                                        //   builder: (BuildContext context) =>
                                        //       Dialog(
                                        //     // alignment: Alignment.topRight,
                                        //     child: SizedBox(
                                        //       height: size.height / 1,
                                        //       width: size.width,
                                        //       child: const ProfileView(),
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      title: Text(
                                        value.docs[index]["businessName"],
                                        style: const TextStyle(
                                            fontSize: 17, color: appBarColor),
                                      ),
                                      leading: ExtendedImage.network(
                                        value.docs[index]["photoUrl"],
                                        shape: BoxShape.rectangle,
                                        fit: BoxFit.fitHeight,
                                        borderRadius: BorderRadius.circular(10),
                                        height: ResponsiveValue(context,
                                            defaultValue: 60.0,
                                            conditionalValues: [
                                              Condition.smallerThan(
                                                name: DESKTOP,
                                                value: 30.0,
                                              ),
                                            ]).value,
                                        width: ResponsiveValue(
                                          context,
                                          defaultValue: 60.0,
                                          conditionalValues: [
                                            Condition.smallerThan(
                                              name: DESKTOP,
                                              value: 30.0,
                                            ),
                                          ],
                                        ).value,
                                        enableMemoryCache: true,
                                      ),
                                      subtitle: Text(
                                        value.docs[index]["categories"],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton.extended(
                      //   hoverColor: Colors.white,
                      backgroundColor: appBarColor,
                      onPressed: () async {
                        liveLocaion.getLocationPro();
                        CameraPosition userLocation = CameraPosition(
                          target:
                              // LatLng(29.9712422, 31.2740701),
                              LatLng(liveLocaion.liveLtitude ?? 29.9712422,
                                  liveLocaion.liveLongitude ?? 31.2740701),
                          tilt: 20,
                          bearing: 20,
                          zoom: 14.4746,
                        );

                        final GoogleMapController controller =
                            await _controller.future;
                        controller.moveCamera(
                            CameraUpdate.newCameraPosition(userLocation));
                      },
                      label: const Icon(Icons.location_on_outlined),
                      //  icon: const Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            return const Text("Erorr");
          },
        );
      },
    );
  }

  googelM(QuerySnapshot val, Iterable markers) {
    return Consumer(
      builder: (context, ref, child) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(29.9712422, 31.2740701),
            tilt: 20,
            bearing: 20,
            zoom: 14.4746,
          ),
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          compassEnabled: true,
          rotateGesturesEnabled: true,
          mapToolbarEnabled: true,
          tiltGesturesEnabled: true,
          myLocationEnabled: true,
          minMaxZoomPreference: MinMaxZoomPreference.unbounded,
          onCameraMove: (position) {
            position.zoom;
            position.bearing;
          },
          // onCameraIdle: () {},
          // onCameraMoveStarted: () {},
          //  gestureRecognizers: <dynamic>{}
          // ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          // ..add(
          //     Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
          // ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
          // ..add(Factory<VerticalDragGestureRecognizer>(
          //     () => VerticalDragGestureRecognizer())),
          onMapCreated: (GoogleMapController controller) async {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
        );
      },
    );
  }
}
