import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/change_notifiiers.dart';
import '../text-styles.dart';

class UserLogIn extends StatefulWidget {
  const UserLogIn({
    super.key,
  });
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
      backgroundColor: appBarColor,
      body: Consumer(builder: (context, ref, child) {
        // refresh() {
        //   return ref.refresh(authStateStraem);
        // }

        final isUser = ref.read(isUserNotifer);
        final userSignIn = ref.read(signIn);
        final changeUserNotifer = ref.read(isChangeUserNotifer);
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // const Text(
                //   "Welcome to clowd stores",
                //   style: TextStyle(fontSize: 25, color: Colors.white),
                // ),
                Image.asset(
                  'assets/logInUser.png',
                  height: 280,
                  width: 400,
                ),
                SizedBox(
                  width: size.width / 1.2,
                  child: const Divider(
                    //    height: size.height * 0.01,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Shop Smart, Shop Local",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                // const Text(
                //   "Sign In as customer",
                //   style: TextStyle(fontSize: 25, color: Colors.white),
                // ),
                const SizedBox(
                  height: 20,
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    //  user.changeStoreToken();

                    await userSignIn.signInWithGoogle();

                    //  context.replace("/");
                    // : const CircularProgressIndicator();
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
