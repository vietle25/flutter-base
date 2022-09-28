import 'package:flutter_base/models/user/user_model.dart';
import 'package:get/get.dart';

class Globals {
  static Rx<UserModel> user = UserModel().obs;
  static String? language;
  static String? token = '';
  static String accessTokenAPI = '';
  static String firebaseToken = '';
  static String? deviceToken = '';
  static var numUnreadNotify = 0.obs; // Number unread notification

  static Function onNavigationPush = () => {}; // Push page function
  static Function onNavigationChange = () => {}; // Navigation change
}
