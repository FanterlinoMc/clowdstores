// import 'package:firebase_auth/firebase_auth.dart';

import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/responive.dart';
// import 'package:provider/provider.dart';

class OpeningView extends StatelessWidget {
  const OpeningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 10.5),
          Center(
            child: Container(
              width: ResponsiveValue(context, defaultValue: 400.0, valueWhen: [
                const Condition.smallerThan(
                  name: TABLET,
                  value: 400.0,
                ),
                const Condition.smallerThan(
                  name: DESKTOP,
                  value: mW,
                ),
              ]).value,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: appBarColor,
                    width: 2,
                  ),
                  borderRadius: (BorderRadius.circular(30))),
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: const [
                  Text(
                    "Welcome to Clowd Stores",
                    style: TextStyle(fontSize: 25, color: appBarColor),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Grow you're Buisness with our",
                    style: TextStyle(fontSize: 22, color: appBarColor),
                  ),
                  SizedBox(height: 10.0),
                  Text(" unfind Paltform That's Quick and Easy To Use",
                      style: TextStyle(fontSize: 18, color: appBarColor)),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 7.5),
              Container(
                width: MediaQuery.of(context).size.width / 3.1,
                height: 44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: appBarColor),
                child: MaterialButton(
                  onPressed: () {
                    context.go(
                      '/StoreLogIn',
                    );
                  },
                  child: const Text(
                    "Store Owner",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              Container(
                width: MediaQuery.of(context).size.width / 3.2,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: appBarColor,
                    width: 2.0,
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    context.go("/UserLogIn");
                  },
                  child: const Text(
                    "Customer",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
