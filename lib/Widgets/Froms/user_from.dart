import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/change_notifiiers.dart';
import '../../helpers/streams_providers.dart';

class UserLogIn extends StatefulWidget {
  const UserLogIn({
    Key? key,
  }) : super(key: key);
  @override
  State<UserLogIn> createState() => _UserLogInState();
}

class _UserLogInState extends State<UserLogIn> {
  final TextEditingController numberController = TextEditingController();
  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        refresh() {
          return ref.refresh(authStateStraem);
        }

        final isUser = ref.read(isUserNotifer);
        final userSignIn = ref.read(signIn);
        final changeUserNotifer = ref.read(isChangeUserNotifer);
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Welcome to clowd stores",
                  style: TextStyle(fontSize: 25, color: appBarColor),
                ),
                const Text(
                  "Shop Smart, Shop Local",
                  style: TextStyle(fontSize: 25, color: appBarColor),
                ),
                const Text(
                  "Sign In as customer",
                  style: TextStyle(fontSize: 25, color: appBarColor),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Divider(
                    height: size.height * 0.02,
                    color: appBarColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {
                    //  user.changeStoreToken();
                    context.go("/");

                    userSignIn.signInWithGoogle();
                    changeUserNotifer.chageUser(true);
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
        );
      }),
    );
  }
}
