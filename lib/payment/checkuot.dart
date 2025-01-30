// // /*
// //  * Copyright (c) 2021 Shady Boshra.
// //  * IN: https://LinkedIn.com/in/ShadyBoshra2012
// //  * GitHub: https://github.com/ShadyBoshra2012
// //  * Mostaql: https://mostaql.com/u/ShadyBoshra2012
// //  */

// import 'dart:async';
// import 'dart:io' show Platform;

// import 'package:flutter/material.dart';
// import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
// import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
// import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';

// class Pay extends StatefulWidget {
//   const Pay({super.key});

//   @override
//   _PayState createState() => _PayState();
// }

// class _PayState extends State<Pay> {
//   final String _instructions = 'Tap on "Pay" Button to try PayTabs plugin';

//   @override
//   void initState() {
//     super.initState();
//   }

//   PaymentSdkConfigurationDetails generateConfig() {
//     var billingDetails = BillingDetails("John Smith", "email@domain.com",
//         "+97311111111", "st. 12", "ae", "dubai", "dubai", "12345");
//     var shippingDetails = ShippingDetails("John Smith", "email@domain.com",
//         "+97311111111", "st. 12", "ae", "dubai", "dubai", "12345");
//     List<PaymentSdkAPms> apms = [];
//     apms.add(PaymentSdkAPms.FAWRY);
//     var configuration = PaymentSdkConfigurationDetails(
//         profileId: "*profile id*",
//         serverKey: "*server key*",
//         clientKey: "*client key*",
//         cartId: "12433",
//         cartDescription: "Flowers",
//         merchantName: "Flowers Store",
//         screentTitle: "Pay with Card",
//         amount: 20.0,
//         showBillingInfo: true,
//         forceShippingInfo: false,
//         currencyCode: "SAR",
//         merchantCountryCode: "SA",
//         billingDetails: billingDetails,
//         shippingDetails: shippingDetails,
//         alternativePaymentMethods: apms,
//         linkBillingNameWithCardHolderName: true);

//     var theme = IOSThemeConfigurations();

//     //theme.logoImage = "assets/logo.png";

//     configuration.iOSThemeConfigurations = theme;

//     return configuration;
//   }

//   Future<void> payPressed() async {
//     FlutterPaytabsBridge.startCardPayment(generateConfig(), (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           var transactionDetails = event["data"];
//           // print(transactionDetails);
//           if (transactionDetails["isSuccess"]) {
//             // print("successful transaction");
//           } else {
//             // print("failed transaction");
//           }

//           // print(transactionDetails["isSuccess"]);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       });
//     });
//   }

//   Future<void> apmsPayPressed() async {
//     FlutterPaytabsBridge.startAlternativePaymentMethod(generateConfig(),
//         (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           // var transactionDetails = event["data"];
//           // print(transactionDetails);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       });
//     });
//   }

//   Future<void> applePayPressed() async {
//     var configuration = PaymentSdkConfigurationDetails(
//         profileId: "*Profile id*",
//         serverKey: "*server key*",
//         clientKey: "*client key*",
//         cartId: "12433",
//         cartDescription: "Flowers",
//         merchantName: "Flowers Store",
//         amount: 20.0,
//         currencyCode: "AED",
//         merchantCountryCode: "ae",
//         merchantApplePayIndentifier: "merchant.com.bunldeId",
//         simplifyApplePayValidation: true);
//     FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           // Handle transaction details here.
//           // var transactionDetails = event["data"];
//           // print(transactionDetails);
//         } else if (event["status"] == "error") {
//           // Handle error here.
//         } else if (event["status"] == "event") {
//           // Handle events here.
//         }
//       });
//     });
//   }

//   Widget applePayButton() {
//     if (Platform.isIOS) {
//       return TextButton(
//         onPressed: () {
//           applePayPressed();
//         },
//         child: const Text('Pay with Apple Pay'),
//       );
//     }
//     return const SizedBox(height: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('PayTabs Plugin Example App'),
//         ),
//         body: Center(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//               Text(_instructions),
//               const SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {
//                   payPressed();
//                 },
//                 child: const Text('Pay with Card'),
//               ),
//               const SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {
//                   apmsPayPressed();
//                 },
//                 child: const Text('Pay with Alternative payment methods'),
//               ),
//               const SizedBox(height: 16),
//               applePayButton()
//             ])),
//       ),
//     );
//   }
// }
// // import 'dart:async';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_fawry_pay/flutter_fawry_pay.dart';



// // class Pay extends StatefulWidget {
// //   @override
// //   _PayState createState() => _PayState();
// // }

// // class _PayState extends State<Pay> {
// //   bool _isFawryPayInit = false;
// //   bool _isInitPayment = false;
// //   bool _isInitCardToken = false;
// //   bool _reset = false;
// //   String _text = "";

// //   late StreamSubscription _fawryCallbackResultStream;

// //   @override
// //   void initState() {
// //     super.initState();
// //     initFawryPay();
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _fawryCallbackResultStream.cancel();
// //   }

// //   Future<void> initFawryPay() async {
// //     try {
// //       _isFawryPayInit = await FlutterFawryPay.instance.init(
// //         // Set the merchant ID here for one time only.
// //       //  merchantID: Keys.merchantID,
// //       merchantID: _text,
// //         style: Style.STYLE1,
// //         // If set to true, you must set username and email.
// //         skipCustomerInput: true,
// //         // Must be a phone number.
// //         username: "01234567890",
// //         email: "abc@test.com",
// //         // For web how you show the Fawry screen.
// //         webDisplayMode: DisplayMode.SIDE_PAGE,
// //         // You should set environment here.
// //         environment: Environment.TEST,
// //       );

// //       _fawryCallbackResultStream =
// //           FlutterFawryPay.instance.callbackResultStream().listen((event) {
// //         Map<dynamic, dynamic> data = event;
// //         FawryResponse response = FawryResponse.fromMap(data);
// //         setState(() => _text = response.toString());
// //       });

// //       setState(() {});
// //     } catch (ex) {
//       // print(ex);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Plugin example app'),
// //         ),
// //         body: Column(
// //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //           children: [
// //             Center(
// //               child: Text('FawryPay Init? $_isFawryPayInit'),
// //             ),
// //             Center(
// //               child: Text('Init Payment? $_isInitPayment'),
// //             ),
// //             Center(
// //               child: Text('Init Card Token? $_isInitCardToken'),
// //             ),
// //             Center(
// //               child: Text('$_text'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 _isInitPayment = await FlutterFawryPay.instance.initialize(
// //                   returnUrl: "test.com", // For Web use only.
// //                   items: [
// //                     FawryItem(
// //                         sku: "1", description: "Item 1", qty: 1, price: 20.0),
// //                   ],
// //                   customParam: {
// //                     "order_id": "123213",
// //                     "price": 231.0,
// //                   },
// //                 );
// //                 setState(() {
// //                   if (_isInitPayment) {
// //                     _isInitCardToken = false;
// //                   }
// //                 });
// //               },
// //               child: Text("Init for Payment"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 _isInitCardToken =
// //                     await FlutterFawryPay.instance.initializeCardTokenizer(
// //                   customerMobile: "01234567890",
// //                   customerEmail: "abc@test.com",
// //                   customParam: {
// //                     "order_id": "123213",
// //                     "price": 231.0,
// //                   },
// //                 );
// //                 setState(() {
// //                   if (_isInitCardToken) {
// //                     _isInitPayment = false;
// //                   }
// //                 });
// //               },
// //               child: Text("Init for Card Token"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 FawryResponse response =
// //                     await FlutterFawryPay.instance.startProcess();
// //                 setState(() {
// //                   _text = "Your result: $response";
// //                 });
// //               },
// //               child: Text("Start Payment"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 _reset = await FlutterFawryPay.instance.reset();
// //                 setState(() {
// //                   if (_reset) {
// //                     _isInitPayment = false;
// //                     _isInitCardToken = false;
// //                   }
// //                 });
// //               },
// //               child: Text("Reset Payment"),
// //             ),
// //             FawryButton(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }\

