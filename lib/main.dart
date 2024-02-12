import 'package:clowdstores/Widgets/text-styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';
import 'helpers/router.dart';
import 'scroll_behavior.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent));

  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // usePathUrlStrategy();
  // PendingDynamicLinkData? linkData =
  //     await FirebaseDynamicLinks.instance.getInitialLink();
  // String? link = linkData?.link.toString();
  //  final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  // initMeeduPlayer();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  final firestoreService = FirestoreService();
    // final userStore = UserStore();
    return MaterialApp.router(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: appBarColor),
      //routeInformationProvider: router.routeInformationProvider,
      routerConfig: clowdRouter,
      //  routerDelegate: clowdRouter.routerDelegate,
      //   routeInformationParser: clowdRouter.routeInformationParser,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: "Clowd Stores ",
    );
  }
}
