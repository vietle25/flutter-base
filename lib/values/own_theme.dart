import 'package:flutter/material.dart';

class OwnThemeFields {
  final Color? textInputBackground;

  const OwnThemeFields({this.textInputBackground});

  factory OwnThemeFields.empty() {
    return OwnThemeFields(textInputBackground: Color(0xFFE9E9E9));
  }
}

extension ThemeDataExtensions on ThemeData {
  static Map<InputDecorationTheme, OwnThemeFields> _own = {};

  void addOwn(OwnThemeFields own) {
    _own[this.inputDecorationTheme] = own;
  }

  static OwnThemeFields? empty = null;

  OwnThemeFields own() {
    var o = _own[this.inputDecorationTheme];
    if (o == null) {
      if (empty == null) empty = OwnThemeFields.empty();
      o = empty;
    }
    return o!;
  }
}

OwnThemeFields ownTheme(BuildContext context) => Theme.of(context).own();
