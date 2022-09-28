import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/controllers/home_controller.dart';
import 'package:flutter_base/models/common/app_bar_model.dart';
import 'package:flutter_base/views/base/base_view.dart';
import 'package:get/get.dart';

import '../../styles/common_style.dart';
import '../../values/colors.dart';

class HomeView extends BaseView {
  final HomeController _homeController =
      Get.put(HomeController()); // Home controller

  /// Render app bar
  @override
  PreferredSizeWidget? renderAppBar(
      {required BuildContext context, AppBarModel? appBarModel}) {
    return AppBar(
      leading: null,
      centerTitle: false,
      elevation: 0,
      shadowColor: Colors.shadow,
      title: const Text("Home"),
      titleSpacing: 16,
      titleTextStyle: CommonStyle.textXLargeBold(color: Colors.white),
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget renderBody({BuildContext? context}) {
    return Container();
  }

  @override
  Future<bool> onWillPop() async {
    super.onWillPop();
    _homeController.showDialogExit();
    return false;
  }
}
