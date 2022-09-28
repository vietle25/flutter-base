import 'package:flutter/material.dart';
import 'package:flutter_base/router/router_config.dart';
import 'package:flutter_base/views/home/home_view.dart';

class MainView extends StatelessWidget {
  MainView({this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    switch (title) {
      case RouterConfig.routeHome:
        return HomeView();
      case RouterConfig.routeHome:
        return HomeView();
      case RouterConfig.routeHome:
        return HomeView();
      default:
        return HomeView();
    }
  }
}
