import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../Data/fire_store_streams.dart';
import '../../Data/sign_In_google.dart';
import '../../Widgets/button.dart';

class DashBrod extends StatelessWidget {
  final dynamic storeInfo;
  DashBrod({Key? key, this.storeInfo}) : super(key: key);

  final googleUser = SignInWithGoogle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          leading: kIsWeb
              ? const SizedBox.shrink()
              : const BackButton(color: appBarColor),
          backgroundColor: kIsWeb ? Colors.white : appBarColor,
          actions: [
            IconButton(
              color: appBarColor,
              icon: const Icon(Icons.logout_sharp),
              onPressed: () {
                googleUser.signOut();
                // context.refresh(authStateStraem);
                context.go('/');
              },
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CloudButton(
                    name: "add Products",
                    onPressed: () async {
                      context.push(
                        '/AddProduct',
                      );
                    },
                  ),
                  CloudButton(
                    name: "Edite Profile",
                    onPressed: () {
                      context.push('/AddBusiness');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CloudButton(
                      name: "Orders",
                      onPressed: () {
                        context.push('/OrderPage');
                      }),
                  CloudButton(
                      name: "Post",
                      onPressed: () {
                        context.push('/PostPage');
                      }),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
