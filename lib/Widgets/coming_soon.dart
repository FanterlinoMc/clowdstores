import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clowdstores/Data/fire_store_streams.dart';
import 'package:clowdstores/Widgets/button.dart';
import 'package:clowdstores/Widgets/text_filed.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: appBarColor,
      title: Text(
        "Coming soon",
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        "Coming soon in the next update",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class Exption extends StatelessWidget {
  final String erorr;
  const Exption({
    Key? key,
    required this.erorr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appBarColor,
      title: const Text(
        "Something went wrong",
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        erorr,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class UserNumber extends StatefulWidget {
  final String storeId;
  const UserNumber({
    Key? key,
    required this.storeId,
  }) : super(key: key);

  @override
  State<UserNumber> createState() => _UserNumberState();
}

final TextEditingController numberController = TextEditingController();

class _UserNumberState extends State<UserNumber> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final order = ref.read(orderNotifer);
      final isUser = ref.read(orderNotifer);
      return Dialog(
        backgroundColor: Colors.white,
        // title: Text(
        //   "Enter your Phone number",
        //   style: TextStyle(color: Colors.white),
        // ),
        child: SizedBox(
          width: 400,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Enter your Phone number",
                style: TextStyle(color: appBarColor, fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: MyTextfiled(
                    onChanged: (value) => isUser.chnageUserNumber(value),
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    labelText: "Enter your mobile number",
                    hintText: "Enter your mobile number",
                    controller: numberController),
              ),
              CloudButton(
                  name: "done",
                  onPressed: () {
                    //context.push('/');
                    order.saveOrder(widget.storeId);
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      );
    });
  }
}

class ClowdSliverAppBar extends StatelessWidget {
  late final Widget? title;
  ClowdSliverAppBar({Key? key, this.title}) : super(key: key);
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackBar({required String message, int duration = 5}) {
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      title: title,
      leading: const SizedBox.shrink(),
      backgroundColor: kIsWeb ? Colors.white : appBarColor,
    );
  }
}