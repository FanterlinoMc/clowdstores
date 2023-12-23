import 'package:clowdstores/Widgets/text_filed.dart';
import 'package:flutter/material.dart';

class CheckFrom extends StatefulWidget {
  const CheckFrom({super.key});

  @override
  State<CheckFrom> createState() => _CheckFromState();
}

final TextEditingController addrees = TextEditingController();
final TextEditingController phone = TextEditingController();
final TextEditingController name = TextEditingController();

class _CheckFromState extends State<CheckFrom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyTextfiled(
            labelText: "addrees", hintText: 'Addrees', controller: addrees),
        MyTextfiled(labelText: "name", hintText: 'name', controller: name ),
        MyTextfiled(labelText: "phone", hintText: 'phone', controller: phone  ),
      ],
    );
  }
}
