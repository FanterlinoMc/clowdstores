import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/change_notifiiers.dart';
import '../../helpers/responive.dart';
import '../text-styles.dart';

class SgingInPage extends StatefulWidget {
  const SgingInPage({super.key});

  @override
  State<SgingInPage> createState() => _SgingInPageState();
}

class _SgingInPageState extends State<SgingInPage> {
  @override
  Widget build(BuildContext context) {
    //final user = SignInWithGoogle();

//TODO fix the  sign in functionality signn in in the first instance
    return Scaffold(
      backgroundColor: appBarColor,
      body: Consumer(builder: (context, ref, child) {
        final userSignIn = ref.read(signIn);
        // final store = ref(storeNotifer);
        //FirebaseAuth auth;s
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: <Widget>[
              // SizedBox(height: MediaQuery.of(context).size.height / 10.),
              Container(
                width: ResponsiveValue(context,
                    defaultValue: 400.0,
                    conditionalValues: [
                      Condition.smallerThan(
                        name: TABLET,
                        value: 400.0,
                      ),
                      Condition.smallerThan(
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
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(height: 10.0),
                    Text(" unfind Paltform That's Quick and Easy To Use",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                shape: Border.all(color: appBarColor),
                onPressed: () async {
                  //  user.changeStoreToken();
                  userSignIn.signInWithGoogle();

                  context.push('/OpeningView');
                },
              ),
              TextButton(
                child: const Text("Privacy Policy"),
                onPressed: () {
                  context.go("/Privacy");
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
