import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final String userProfile = 'userProfile'; // Save user profile
  static final String language = 'language'; // Save language
  static final String accessTokenAPI = 'accessTokenAPI'; // Access token api
  static final String deviceToken = 'deviceToken'; // Device token
  static final String firebaseToken = 'firebaseToken'; // Firebase token
  static final String theme = 'theme'; // Firebase token

  /// Store item
  static Future<void> storeItem(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }

  /// Delete item
  static Future<void> deleteItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// Retrieve item
  static Future<dynamic> retrieveItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);
    if (value != null) {
      return jsonDecode(value);
    }
    return null;
  }

  /// Delete all
  static Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
