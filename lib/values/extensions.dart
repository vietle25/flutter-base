import 'package:flutter/material.dart';

extension MYContext on BuildContext {
  Color dynamicColor({required int light, required int dark}) {
    return (Theme.of(this).brightness == Brightness.light)
        ? Color(light)
        : Color(dark);
  }

  Color dynamicColour({required Color light, required Color dark}) {
    return (Theme.of(this).brightness == Brightness.light) ? light : dark;
  }

  /// the white background
  Color get bgWhite => dynamicColor(light: 0xFFFFFFFF, dark: 0xFF000000);
}
