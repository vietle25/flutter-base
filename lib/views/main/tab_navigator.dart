import 'package:flutter/material.dart';
import 'package:flutter_base/values/globals.dart';

import 'main_view.dart';
import 'tab_item.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final TabItem? tabItem; // Tab item
  final GlobalKey<NavigatorState>? navigatorKey; // Navigation key
  final String splash = "/"; // Splash

  /// Push view
  void push(BuildContext context, String routerName) {
    var routeBuilders = _routeBuilders(context, routerName);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[this.getFullRouterName(routerName)]!(context),
      ),
    );
  }

  /// Get router builder
  Map<String, WidgetBuilder> _routeBuilders(
      BuildContext context, String routerName) {
    Globals.onNavigationPush =
        (context, routerName) => push(context, routerName);
    return {
      splash: (context) => MainView(title: tabName[tabItem]),
      // Add view want to keep bottom bar
      // getFullRouterName(RouterConfig.ROUTE_HOME): (context) => HomeView(),
    };
  }

  /// Get full router name
  getFullRouterName(String routeName) {
    return splash + routeName;
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context, splash);
    return Navigator(
      key: navigatorKey,
      initialRoute: splash,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }
}
