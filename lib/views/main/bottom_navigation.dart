import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/fonts.dart';
import 'package:get/get.dart';

import 'tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation(
      {Key? key, required this.currentTab, required this.onSelectTab})
      : super(key: key);

  final TabItem currentTab; // Current tab
  final ValueChanged<TabItem> onSelectTab; // On selected tab
  final _selectedIndex = 0.obs; // Selected index

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: getCurrentIndex(),
      selectedFontSize: Fonts.font12,
      unselectedFontSize: Fonts.font12,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            color: _selectedIndex.value == 0 ? Colors.primary : Colors.grey400,
          ),
          label: Localizes.home.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            color: _selectedIndex.value == 1 ? Colors.primary : Colors.grey400,
          ),
          label: Localizes.home.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: _selectedIndex.value == 2 ? Colors.primary : Colors.grey400,
          ),
          label: Localizes.home.tr,
        ),
      ],
      onTap: onItemTapped,
      selectedItemColor: Colors.primary,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      unselectedLabelStyle: CommonStyle.textSmall(
        color: Colors.grey400,
      ),
      iconSize: 36,
    );
  }

  /// On tap item bottom bar
  void onItemTapped(int index) {
    onSelectTab(
      TabItem.values[index],
    );
  }

  /// Get current index
  int getCurrentIndex() {
    if (currentTab == TabItem.home) {
      _selectedIndex.value = 0;
    } else if (currentTab == TabItem.news) {
      _selectedIndex.value = 1;
    } else if (currentTab == TabItem.profile) {
      _selectedIndex.value = 2;
    }
    return _selectedIndex.value;
  }
}
