import 'package:flutter/material.dart';

import 'text-styles.dart';

class MyTextfiled extends StatefulWidget {
  final String labelText;
  final dynamic color;
  final String hintText;
  final FormFieldSetter? saved;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final double? width;
  final String Function(String?)? validator;
  const MyTextfiled({
    super.key,
    required this.labelText,
    required this.hintText,
    this.saved,
    this.onChanged,
    required this.controller,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.width,
    this.validator,
    this.color,
  });

  @override
  State<MyTextfiled> createState() => _MyTextfiledState();
}

class _MyTextfiledState extends State<MyTextfiled> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: widget.width ?? 550,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: TextFormField(
              validator: widget.validator,
              onSaved: widget.saved,
              autovalidateMode: AutovalidateMode.always,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                errorStyle: TextStyle(color: widget.color),
                labelStyle: const TextStyle(color: appBarColor),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.color ?? appBarColor, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.color ?? appBarColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.color ?? appBarColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.color ?? appBarColor, width: 1.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
