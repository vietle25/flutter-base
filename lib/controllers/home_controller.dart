import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_base/controllers/base_controller.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/models/user/user_model.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final UserRepository? _userRepository = UserRepository.getInstance();
  final ScrollController scrollController = ScrollController();
  final RxDouble scrollY = 0.0.obs;
  Rx<UserModel> userInfo = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    this.initState();
    this.showLoading();
    await this.handleRequest();
    this.closeLoading();
  }

  /// Init state
  initState() {
    this.scrollController.addListener(() {
      this.scrollY.value = this.scrollController.offset;
    });
  }

  @override
  void onClose() {
    super.onClose();
    this.scrollController?.dispose();
  }

  /// Handle refresh
  Future<void> onRefresh() async {
    await this.handleRequest();
  }

  /// Handle request
  Future<void> handleRequest() async {}

  /// Show dialog confirm exit
  showDialogExit() {
    this.showDialogConfirm(
      title: Localizes.confirm.tr,
      content: Localizes.wantToExit.tr,
      confirmText: Localizes.ok.tr,
      confirmAction: () {
        SystemNavigator.pop();
      },
      barrierDismissible: true,
      showIconClose: false,
      showOneButton: false,
    );
  }
}
