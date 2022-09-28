import 'package:flutter/material.dart';
import 'package:flutter_base/controllers/base_controller.dart';
import 'package:flutter_base/models/user/user_model.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  UserRepository? _userRepository = UserRepository.getInstance();
  Rx<UserModel> userModel = UserModel().obs;
  TextEditingController? passwordTextController;
  TextEditingController? userNameTextController;
  var hiddenPassword = true.obs;

  @override
  void onInit() async {
    super.onInit();
    passwordTextController = TextEditingController();
    userNameTextController = TextEditingController();
  }

  Future<void> login() async {
    this.showLoading();
  }

  @override
  void onClose() {
    super.onClose();
    passwordTextController?.dispose();
    userNameTextController?.dispose();
  }
}
