import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/controllers/base_controller.dart';
import 'package:flutter_base/models/user/user_model.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  var valueLanguage = false.obs;
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  UserModel user = UserModel();
  CollectionReference userRepo = FirebaseFirestore.instance.collection('users');

  @override
  void onInit() async {
    super.onInit();
    // passwordTextController = TextEditingController();
    // nameTextController = TextEditingController();
    await getDeviceToken();
  }

  @override
  void onClose() {
    super.onClose();
    passwordTextController.dispose();
    nameTextController.dispose();
  }
}
