import 'package:flutter/cupertino.dart';
import 'package:flutter_base/values/colors.dart';

class ButtonModel {
  String? name;
  Color color;
  Color background;
  int weight;

  ButtonModel({
    this.name,
    this.color = Colors.background,
    this.background = Colors.greyLight,
    this.weight = 1,
  });
}
