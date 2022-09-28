import 'package:flutter_base/views/home/home_view.dart';
import 'package:flutter_base/views/login/login_view.dart';
import 'package:flutter_base/views/main/bottom_navigation_view.dart';
import 'package:get/get.dart';

class RouterConfig {
  static const routeSplash = '/';
  static const routeMain = '/main';
  static const routeHome = '/home';
  static const routeLogin = '/login';
  static const routeProfile = '/profile';

  static final route = [
    GetPage(
      name: routeSplash,
      page: () => LoginView(),
    ),
    GetPage(
      name: routeHome,
      page: () => HomeView(),
    ),
    GetPage(
      name: routeMain,
      page: () => BottomNavigationView(),
    ),
  ];
}
