import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../helpers/responive.dart';
import 'text-styles.dart';

class CloudButton extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;
  final double? elevation;
  final Color? color;

  const CloudButton(
      {super.key,
      required this.name,
      required this.onPressed,
      this.elevation,
      this.color});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
      //  ),
    );
  }
}

class CloudButtonTow extends StatelessWidget {
  final Widget? name;
  final VoidCallback? onPressed;
  final double? elevation;

  const CloudButtonTow({
    super.key,
    required this.name,
    required this.onPressed,
    this.elevation,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:
            ResponsiveValue(context, defaultValue: 50.0, conditionalValues: [
          Condition.smallerThan(name: TABLET, value: bottonH),
          Condition.smallerThan(name: DESKTOP, value: bottonHT),
        ]).value,
        width:
            ResponsiveValue(context, defaultValue: 200.0, conditionalValues: [
          Condition.smallerThan(
            name: TABLET,
            value: bottonW,
          ),
        ]).value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          // color: appBarColor,
        ),
        child: ElevatedButton(
            // splashColor: Colors.white,
            // elevation: elevation,
            onPressed: onPressed,
            child: name),
      ),
    );
  }
}
