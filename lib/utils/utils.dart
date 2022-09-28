import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_base/utils/storage_util.dart';
import 'package:flutter_base/utils/string_util.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/values/globals.dart';
import 'package:get/get.dart';

class Utils {
  /// Checks if data is null.
  static bool isNull(dynamic data) {
    if (data is String &&
        (data.isEmpty || (data.isNotEmpty && data.trim() == ""))) {
      return true;
    }
    return GetUtils.isNull(data);
  }

  /// Check have network connect
  static Future<bool> isNetWorkConnect() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  /// Get width screen
  static double getWidth() => Get.width;

  /// Get height screen
  static double getHeight() => Get.height;

  /// Get status bar height
  static double getStatusBarHeight() => MediaQuery.of(Get.context!).padding.top;

  /// Get width screen percent
  static double getWidthPercent(double percent) => (getWidth() * percent) / 100;

  /// Get height screen percent
  static double getHeightPercent(double percent) =>
      (getHeight() * percent) / 100;

  static String formatBytes(int bytes, {int? decimals}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals ?? 2)) +
        ' ' +
        suffixes[i];
  }

  /// Get language app
  static Future<void> getLocaleLanguageApp() async {
    var data = await StorageUtil.retrieveItem(StorageUtil.language);
    if (!Utils.isNull(data)) {
      Globals.language = data as String?;
    } else {
      Globals.language = Constants.langCountryVN;
    }
    List<String> values = Globals.language!.split('_');
    if (values.length > 1) {
      return Get.updateLocale(Locale(values[0], values[1]));
    }
  }

  /// Random
  static random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  /// Get header request
  static getHeaderRequest() {
    Map<String, String> headers = Map<String, String>();
    // headers.addAll({"x-openerp-session-id": Globals.sessionIdChart});
    return headers;
  }

  /// Update avatar
  static updateAvatar({required String url}) {
    int indexQuestionMark = url.indexOf('?');
    if (indexQuestionMark != -1) {
      url = url + '&' + StringUtil.randomString(length: 2);
    } else {
      url = url + '?' + StringUtil.randomString(length: 2);
    }
    return url;
  }

  /// Get status trip button
  static getStatusTripButton(DateTime plannedStartDate, DateTime now) {
    return (plannedStartDate.hour > 12 && now.hour >= 12) ||
        (plannedStartDate.hour <= 12 && now.hour <= 12);
  }

  static isDarkMode() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark;
  }
}
