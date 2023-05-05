import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:responsive_framework/responsive_framework.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'firebase_options.dart';
import 'helpers/router.dart';
import 'scroll_behavior.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent));

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  usePathUrlStrategy();
  // PendingDynamicLinkData? linkData =
  //     await FirebaseDynamicLinks.instance.getInitialLink();
  // String? link = linkData?.link.toString();
  //  final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  final firestoreService = FirestoreService();
    // final userStore = UserStore();
    return MaterialApp.router(
      scrollBehavior: MyCustomScrollBehavior(),
      //routeInformationProvider: router.routeInformationProvider,
      routerConfig: clowdRouter,
      //  routerDelegate: clowdRouter.routerDelegate,
      //   routeInformationParser: clowdRouter.routeInformationParser,
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        // maxWidth: 1200,
        // minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(600, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(700, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        // background: Container(color: const Color(0xFFF5F5F5))),
      ),
      debugShowCheckedModeBanner: false,
      title: "Clowd Stores ",
    );
  }
}
