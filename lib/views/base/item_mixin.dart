import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/values/extend_theme.dart';

mixin ItemMixin {
  ThemeData getTheme(BuildContext context) => Theme.of(context);

  ExtendTheme getExtTheme(BuildContext context) =>
      Theme.of(context).extension<ExtendTheme>()!;
}
