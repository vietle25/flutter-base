import 'package:flutter/material.dart';
import 'package:flutter_base/values/key.dart';

class FormValidate extends StatefulWidget {
  final List<Widget>? items;
  final GlobalKey<FormState>? key;

  FormValidate({this.items, this.key});

  @override
  _FormValidateState createState() => _FormValidateState();
}

class _FormValidateState extends State<FormValidate> {
  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: widget.key ?? mainKey,
        child: Column(children: widget.items!));
  }
}
