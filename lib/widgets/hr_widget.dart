import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/views/base/item_mixin.dart';

class HrWidget extends StatelessWidget with ItemMixin {
  final Color? color; // Color
  final double? thickness; // Thickness
  final double? heightDivider; // Height divider
  final double? indent; // Indent
  final double? endIndent; // End indent
  final EdgeInsets? margin; //Margin

  HrWidget({
    this.color,
    this.thickness,
    this.heightDivider,
    this.indent,
    this.endIndent,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(left: 0.0, right: 0.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: color ?? getExtTheme(context).hrColor,
              height: heightDivider ?? Constants.borderWidth,
              thickness: thickness ?? Constants.borderWidth,
              indent: indent,
              endIndent: endIndent,
            ),
          ),
        ],
      ),
    );
  }
}
