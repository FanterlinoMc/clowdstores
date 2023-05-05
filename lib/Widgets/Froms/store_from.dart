import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';

import '../../Data/fire_store_streams.dart';
import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class StoreLogIn extends StatefulWidget {
  const StoreLogIn({Key? key}) : super(key: key);

  @override
  State<StoreLogIn> createState() => _StoreLogInState();
}

class _StoreLogInState extends State<StoreLogIn> {
  @override
  Widget build(BuildContext context) {
    //final user = SignInWithGoogle();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        refresh() {
          return ref.refresh(authStateStraem);
        }

        final isUser = ref.read(isUserNotifer);
        final changeUserNotifer = ref.read(isChangeUserNotifer);
        final userSignIn = ref.read(signIn);
        // final store = ref(storeNotifer);
        //FirebaseAuth auth;s
        return Center(
          child: SingleChildScrollView(
            child: SizedBox(
              //     color: const Color(0xFF082032),
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Welcome to ClowdStores",
                    style: TextStyle(fontSize: 25, color: appBarColor),
                  ),
                  const SizedBox(height: 10),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {
                      //  user.changeStoreToken();
                      context.go('/');
                      userSignIn.signInWithGoogle();
                      changeUserNotifer.chageUser(false);
                      changeUserNotifer.saveChanageUser();
                      isUser.saveUser();
                      refresh();
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
            ),
          ),
        );
      }),
    );
  }
}
