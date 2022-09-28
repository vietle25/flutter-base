import 'package:flutter/material.dart';

@immutable
class ExtendTheme extends ThemeExtension<ExtendTheme> {
  final Color inputBackground;
  final Color hintColor;
  final Color buttonColor;
  final Color iconSecondColor;
  final Color errorTextColor;
  final Color unseenTextColor;
  final Color seenTextColor;
  final Color inputMessageColor;
  final Color messageColor;
  final Color hrColor;
  final Color buttonTextColor;

  const ExtendTheme({
    this.inputBackground = const Color(0xFFE9E9E9),
    this.hintColor = const Color(0xFF262626),
    this.buttonColor = const Color(0xFF2884a9),
    this.iconSecondColor = const Color(0xFFC7C7C7),
    this.errorTextColor = const Color(0xFFFF2424),
    this.unseenTextColor = const Color(0xFF262626),
    this.seenTextColor = const Color(0xFF3B3B3B),
    this.inputMessageColor = const Color(0xFF3B3B3B),
    this.messageColor = const Color(0x519E9E9E),
    this.hrColor = const Color(0x51D0CECE),
    this.buttonTextColor = const Color(0xFFE9E9E9),
  });

  @override
  ExtendTheme copyWith({
    Color? inputBackground,
  }) {
    return ExtendTheme(
      inputBackground: inputBackground ?? this.inputBackground,
      hintColor: hintColor ?? this.hintColor,
      buttonColor: buttonColor ?? this.buttonColor,
      iconSecondColor: iconSecondColor ?? this.iconSecondColor,
      errorTextColor: errorTextColor ?? this.errorTextColor,
    );
  }

  @override
  ExtendTheme lerp(ThemeExtension<ExtendTheme>? other, double t) {
    if (other is! ExtendTheme) {
      return this;
    }
    return ExtendTheme(
      inputBackground:
          Color.lerp(inputBackground, other.inputBackground, t) ?? Colors.white,
      hintColor: Color.lerp(hintColor, other.hintColor, t) ?? Color(0xFF262626),
    );
  }

  @override
  String toString() => 'MyCardTheme('
      'background: $inputBackground)';
}
