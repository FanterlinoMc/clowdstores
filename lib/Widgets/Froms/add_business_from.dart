import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clowdstores/Models/store.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Data/fire_store_streams.dart';
import '../../Data/sign_In_google.dart';
import '../../helpers/upload_phtoto.dart';
import '../button.dart';
import '../drop_down.dart';
import '../text-styles.dart';
import '../text_filed.dart';
import '../../helpers/change_notifiiers.dart';

class AddBusiness extends StatefulWidget {
  final StoreModel? storeModel;
  final DocumentSnapshot? storeInfo;
  const AddBusiness({
    Key? key,
    this.storeModel,
    this.storeInfo,
  }) : super(key: key);

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final TextEditingController _businessName = TextEditingController();

  final TextEditingController _city = TextEditingController();

  final TextEditingController _businessPhone = TextEditingController();

  final TextEditingController _businessAdress = TextEditingController();

  final TextEditingController _businessEmail = TextEditingController();

  final TextEditingController _webAdress = TextEditingController();

  final TextEditingController _workingHours = TextEditingController();
  final TextEditingController _productTypeController0 = TextEditingController();
  final TextEditingController _productTypeController1 = TextEditingController();
  final TextEditingController _productTypeController2 = TextEditingController();
  @override
  // @override
  // void initState() {
  //   if (widget.storeInfo == null) {
  //     _businessName.text = "";
  //     _city.text = "";
  //     _businessPhone.text = "";
  //     _businessAdress.text = "";
  //     _businessEmail.text = "";
  //     _webAdress.text = "";
  //     _businessName.text = "";
  //     _workingHours.text = "";
  //     FutureProvider((ref) {
  //       final productProvider = ref.read(storeProvider);
  //       return productProvider.laodStores(widget.storeModel!);
  //     });
  //   } else {
  //     _businessName.text = widget.storeInfo?["businessName"];
  //     _city.text = widget.storeInfo?["city"];
  //     _businessPhone.text = widget.storeInfo?["businessPhone"];
  //     _businessAdress.text = widget.storeInfo?["businesaddress"];
  //     _businessEmail.text = widget.storeInfo?["businessEmail"];
  //     _webAdress.text = widget.storeInfo?["webAddress"];
  //     _businessName.text = widget.storeInfo?["businessName"];
  //     _workingHours.text = widget.storeInfo?["workingHours"];
  //     FutureProvider((ref) {
  //       final productProvider = ref.read(storeProvider);
  //       return productProvider.laodStores(widget.storeModel!);
  //     });
  //   }
  //   super.initState();
  // }

  void dispose() {
    _businessName.dispose();
    _city.dispose();
    _businessPhone.dispose();
    _businessAdress.dispose();
    _businessEmail.dispose();
    _webAdress.dispose();
    _businessName.dispose();
    _workingHours.dispose();
    _productTypeController0.dispose();
    _productTypeController1.dispose();
    _productTypeController2.dispose();
    super.dispose();
  }

  UploadTask? task;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final googleUser = SignInWithGoogle();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Consumer(
            builder: (context, ref, child) {
              final store = ref.watch(storeNotifer.notifier);
              // final product = ref(productPro);
              final validators = ref.read(validatorProvider);
              return Center(
                child: SizedBox(
                  width: ResponsiveValue(context,
                      defaultValue: 500.0,
                      conditionalValues: [
                        Condition.smallerThan(
                          name: DESKTOP,
                          value: size.width,
                        ),
                      ]).value,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        centerTitle: true,
                        // title: const Text(
                        //   "Add Product",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     color: kIsWeb ? appBarColor : Colors.white,
                        //   ),
                        // ),
                        leadingWidth: 130,
                        leading: OutlinedButton(
                          onPressed: () {
                            googleUser.signOut();
                            context.go('/OpeningView');
                          },
                          child: const Text(
                            "Switch to Consumer",
                            style: TextStyle(
                              fontSize: 16,
                              color: kIsWeb ? appBarColor : Colors.white,
                            ),
                          ),
                        ),
                        // leadingWidth: size.width / 4,
                        // leading:
                        backgroundColor: kIsWeb ? Colors.white : appBarColor,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  "Enter your Business Details",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: appBarColor,
                                  ),
                                ),
                              ),
                            ),
                            MyTextfiled(
                              // color: validators.isNameValid
                              //     ? appBarColor
                              //     : Colors.green,
                              validator: (value) =>
                                  validators.businessName(value!),
                              color: validators.isNameValid
                                  ? appBarColor
                                  : Colors.green,
                              labelText: "Business Name ",
                              hintText: "Business Name ",
                              onChanged: (value) {
                                store.changeBusinessName(value);
                                validators.businessName(value);
                              },
                              controller: _businessName,
                            ),
                            MyTextfiled(
                              maxLength: 11,
                              color: validators.isNumberValid
                                  ? appBarColor
                                  : Colors.green,
                              validator: (value) =>
                                  validators.businessPhone(value!),
                              labelText: "Business Phone",
                              hintText: "Business Phone",
                              keyboardType: TextInputType.number,
                              onChanged: (value) =>
                                  store.changeBusinessPhone(value),
                              controller: _businessPhone,
                            ),
                            MyTextfiled(
                              validator: (value) =>
                                  validators.businessAddress(value!),
                              color: validators.isAddressValid
                                  ? appBarColor
                                  : Colors.green,
                              labelText: "Business Address",
                              hintText: "Business Address",
                              onChanged: (value) =>
                                  store.cahangeBusinessAdress(value),
                              controller: _businessAdress,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10, right: 10),
                              child: DropDown(),
                            ),
                            MyTextfiled(
                              color: validators.isCityValid
                                  ? appBarColor
                                  : Colors.green,
                              validator: (value) =>
                                  validators.businessCity(value!),
                              labelText: "City",
                              hintText: "City",
                              onChanged: (value) => store.changeCity(value),
                              controller: _city,
                            ),
                            MyTextfiled(
                              color: validators.isHourValid
                                  ? appBarColor
                                  : Colors.green,
                              validator: (value) =>
                                  validators.isValidHour(value!),
                              labelText: "Working Hours",
                              hintText: "Working Hours",
                              keyboardType: TextInputType.number,
                              onChanged: (value) =>
                                  store.changeWorkingHours(value),
                              controller: _workingHours,
                            ),
                            MyTextfiled(
                              color: validators.isWebValid
                                  ? appBarColor
                                  : Colors.green,
                              validator: (value) =>
                                  validators.businessWeb(value!),
                              labelText: "Web Address",
                              hintText: "Optional",
                              onChanged: (value) =>
                                  store.changeWebAddress(value),
                              controller: _webAdress,
                            ),
                            const SizedBox(height: 6),
                            const StoreUplaodPage(),
                            CloudButton(
                                color: validators.isWebValid
                                    ? Colors.blueGrey
                                    : appBarColor,
                                name: "Next",
                                onPressed: validators.isWebValid
                                    ? null
                                    : () {
                                        //  store.isStoreOwner();
                                        // store.changeStoreToken();
                                        //product.createProductCateory()
                                        store.getLocationPro();
                                        store.saveUserBusiness();
                                        context.go('/ProductType');
                                      }),
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
