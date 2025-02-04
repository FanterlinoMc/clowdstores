// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Data/fire_store_streams.dart';
import '../../Widgets/text-styles.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/responive.dart';
import '../../helpers/streams_providers.dart';
// import 'package:provider/provider.dart';

class OpeningView extends StatelessWidget {
  const OpeningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      body: Consumer(builder: (context, ref, child) {
        final changeUserNotifer = ref.read(isChangeUserNotifer);
        final saveUser = ref.read(isUserNotifer);
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10.5),
            Center(
              child: Container(
                width: ResponsiveValue(context,
                    defaultValue: 400.0,
                    conditionalValues: [
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
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: (BorderRadius.circular(30))),
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: const Column(
                  children: [
                    Text(
                      "Welcome to Clowd Stores",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Grow you're Buisness with our",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 10.0),
                    Text(" unfind Paltform That's Quick and Easy To Use",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 7.5),
                Container(
                  width: MediaQuery.of(context).size.width / 2.9,
                  height: 44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: MaterialButton(
                    onPressed: () async {
                      changeUserNotifer.chageUser(false);
                      changeUserNotifer.saveChanageUser();
                      changeUserNotifer.changeUserid(uid!);
                      changeUserNotifer.saveChanageUser();
                      saveUser.changeUserEmail(fUserE!);
                      saveUser.changeUserId(uid!);
                      saveUser.changeUserName(fUserN!);
                      saveUser.changeUserPhotoUrl(fUserP!);
                      print(
                          "'''''''''''''''''''''''''uid'''''''''''''''''''''''''");
                      print(uid);
                      print(fUserN);
                      print(fUserP);
                      print(
                          "''''''''''''''''''''''''fUserP''''''''''''''''''''''''");

                      saveUser.saveUser();
                      ref.invalidate(getchangeUser);
                      context.go('/');
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
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      changeUserNotifer.chageUser(true);
                      changeUserNotifer.changeUserid(uid!);
                      changeUserNotifer.saveChanageUser();
                      saveUser.changeUserEmail(fUserE!);
                      saveUser.changeUserId(uid!);
                      saveUser.changeUserName(fUserN!);
                      saveUser.changeUserPhotoUrl(fUserP!);
                      saveUser.saveUser();
                      ref.invalidate(getchangeUser);

                      context.go('/');
                      //return ref.refresh(getchangeUser);
                    },
                    child: const Text(
                      "Customer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
