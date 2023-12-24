//TODO // all the size should be the same size
import 'package:flutter/material.dart';

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
      height: size.height / 4,
      width: size.width / 4,
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
      height: size.height,
      width: size.width / 3,
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