import 'package:flutter_base/router/router_config.dart';

enum TabItem { home, news, profile }

const Map<TabItem, String> tabName = {
  TabItem.home: RouterConfig.routeHome,
  TabItem.news: RouterConfig.routeHome,
  TabItem.profile: RouterConfig.routeHome,
};
