import 'package:flutter/material.dart';
import 'package:flutter_base/locales/localizes.dart';

/// Language
class LanguageCode {
  static const EN = 'en_US'; // Choose from album library
  static const VI = 'vi_VN'; // Capture new image

  /// Convert to locale
  static Locale convertToLocale(String? code) {
    if (code == VI) {
      return Locale(Localizes.viCode);
    }
    return Locale(Localizes.enCode);
  }
}
