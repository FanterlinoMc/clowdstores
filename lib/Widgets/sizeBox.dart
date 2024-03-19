//TODO // all the size should be the same size
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ImageSizeBox extends StatelessWidget {
  final Widget child;
  const ImageSizeBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: ResponsiveValue(context,
          defaultValue: size.height / 3.5,
          conditionalValues: [
            Condition.smallerThan(
              name: TABLET,
              value: size.height / 3.7,
            ),
          ]).value,
      width: ResponsiveValue(context,
          defaultValue: size.height / 4.0,
          conditionalValues: [
            Condition.smallerThan(
              name: TABLET,
              value: size.height / 2.3,
            ),
          ]).value,
      child: child,
    );
  }
}

class WebSizeBox extends StatelessWidget {
  final Widget child;
  const WebSizeBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: ResponsiveValue(context,
          defaultValue: size.height / 2.0,
          conditionalValues: [
            Condition.smallerThan(
              name: TABLET,
              value: size.height / 1.0,
            ),
          ]).value,

      height: size.height,
      //  width: size.width / 2,
      child: child,
    );
  }
}

class ListBox extends StatelessWidget {
  final Widget child;
  const ListBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: ResponsiveValue(context,
          defaultValue: size.height / 4.3,
          conditionalValues: [
            Condition.smallerThan(
              name: TABLET,
              value: size.height / 2.0,
            ),
          ]).value,

      width: ResponsiveValue(context,
          defaultValue: size.height / 4.3,
          conditionalValues: [
            Condition.smallerThan(
              name: TABLET,
              value: size.height / 4.5,
            ),
          ]).value,

      // height: size.height / 2.3,
      // width: size.width / 3,
      child: child,
    );
  }
}

  


//  height: ResponsiveValue(context,
//                                                     defaultValue: 400.0,
//                                                     conditionalValues: [
//                                                       Condition.smallerThan(
//                                                         name: DESKTOP,
//                                                         value: 250.0,
//                                                       ),
//                                                     ]).value,
//                                                 width: ResponsiveValue(
//                                                   context,
//                                                   defaultValue: 400.0,
//                                                   conditionalValues: [
//                                                     Condition.smallerThan(
//                                                       name: TABLET,
//                                                       value: tW,
//                                                     ),
//                                                     Condition.smallerThan(
//                                                       name: DESKTOP,
//                                                       value: mW,
//                                                     ),
//                                                   ],
//                                                 ).value,

// SizedBox(
//                   width: ResponsiveValue(context,
//                       defaultValue: 1000.0,
//                       conditionalValues: [
//                         Condition.smallerThan(
//                           name: TABLET,
//                           value: tW,
//                         ),
//                         Condition.smallerThan(
//                           name: DESKTOP,
//                           value: mW,
//                         ),
//                       ]).value,