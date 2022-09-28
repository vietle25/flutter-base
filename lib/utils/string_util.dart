import 'dart:math';

import 'package:flutter_base/locales/localizes.dart';
import 'package:get/get.dart';

class StringUtil {
  static RegExp passwordRegex =
      RegExp(r'^([\w!_`()+-=$#&@~](?!\.)(?!\:)(?!\;)(?!\,)){6,64}$');
  static RegExp rangePasswordRegex = RegExp(r'^.{6,64}$');
  static RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static RegExp phoneRegExp = RegExp(r'((0[3|5|7|8|9])+([0-9]{8})\b)');
  static RegExp characterJapaneseRegex =
      RegExp(r'^[\.a-zA-Z0-9-_+]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$');
  static RegExp dateRegex = RegExp(
      r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$');
  static RegExp numberRegex = RegExp(r'[0-9]');
  static RegExp specialCharacter = RegExp(r'[!#%^*(),?":{}|[<>/\\\]~_=+;-]');
  static RegExp time24hRegex = RegExp(r'^([01][0-9]|2[0-3]):[0-5][0-9]$');
  static RegExp time12hRegex =
      RegExp(r'^(0[0-9]|1[0-2]):[0-5][0-9] ([AaPpSsCc][MmAaHc])$');
  static RegExp emojiRegex = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
  static RegExp urlRegex = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  /// Check if string has a special character
  static bool hasSpecialCharacter(String value) {
    return specialCharacter.allMatches(value).isNotEmpty;
  }

  /// Check if string has emoji icon
  static bool hasEmojiIcon(String value) {
    return emojiRegex.allMatches(value).isNotEmpty;
  }

  /// Check if date string correct format
  static bool isCorrectDateFormat(String value) {
    return dateRegex.hasMatch(value);
  }

  /// Check if time 12H string correct format
  static bool isCorrectTime12hFormat(String value) {
    return time12hRegex.hasMatch(value);
  }

  /// Check if time 24H string correct format
  static bool isCorrectTime24hFormat(String value) {
    return time24hRegex.hasMatch(value);
  }

  /// Check if string has url
  static bool isURL(String url) {
    return urlRegex.hasMatch(url);
  }

  /// Validate

  /// Validate date
  static String? validateDate(
      {String? value, required bool isValidate, String? textValid}) {
    if (!isValidate) return null;
    if (value!.isEmpty) {
      return Localizes.pleaseEnter(textValid!);
    } else if (!StringUtil.isCorrectDateFormat(value)) {
      return Localizes.incorrectDateFormat.tr;
    }
    return null;
  }

  /// Validate time
  static validateTime24h({String? value, required bool isValidate, String? textValid}) {
    if (!isValidate) return null;
    if (value!.isEmpty) {
      return Localizes.pleaseEnter(textValid!);
    } else if (!StringUtil.isCorrectTime24hFormat(value)) {
      return Localizes.incorrectTimeFormat.tr;
    }
    return null;
  }

  /// Validate time
  static validateTime12h({String? value, required bool isValidate, String? textValid}) {
    if (!isValidate) return null;
    if (value!.isEmpty) {
      return Localizes.pleaseEnter(textValid!);
    } else if (!StringUtil.isCorrectTime12hFormat(value)) {
      return Localizes.incorrectTimeFormat.tr;
    }
    return null;
  }

  /// Validate email
  static validateEmail(String email) {
    return emailRegex.allMatches(email).isNotEmpty;
  }

  /// Replace all sign dots [.] and dash [-]
  static replaceSign(String value) {
    return value.replaceAll(RegExp(r'\.|-| '), '');
  }

  /// Has white space
  static hasWhiteSpace(String value) {
    var split = value.split(" ");
    return split.length > 1;
  }

  static randomString({required int length}) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static bool isOnlyNumber(String str) {
    return numberRegex.hasMatch(str);
  }
}
