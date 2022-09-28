import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_base/controllers/base_controller.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/utils/date_util.dart';
import 'package:flutter_base/utils/storage_util.dart';
import 'package:flutter_base/values/globals.dart';
import 'package:flutter_base/widgets/rename_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';

class ProfileController extends BaseController {
  CollectionReference userRepo = FirebaseFirestore.instance.collection('users');

  var versionApp = "".obs; // Version app

  @override
  void onInit() async {
    super.onInit();
    getVersion();
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionApp.value = packageInfo.version;
  }

  @override
  void onClose() {
    super.onClose();
  }

  pickImage() async {
    XFile? image = await (ImagePicker().pickImage(source: ImageSource.gallery));
    var date = DateUtil.now();
    var dateString = date.toString().split(" ")[0];
    String title = image!.name;
    var titleSplit = title.split(".");
    String ext = titleSplit.last;
    title = titleSplit.join("_") + '_' + dateString + "." + ext;
    try {
      showLoading();
      firebase_storage.TaskSnapshot task = await firebase_storage
          .FirebaseStorage.instance
          .ref('user/$title')
          .putFile(File(image.path));
      String path = await task.ref.getDownloadURL();
      Globals.user.value.avatar = path;
      Globals.user.refresh();
      userRepo
          .doc(Globals.user.value.id)
          .set(Globals.user.value.toJson())
          .then((value) {
        closeLoading();
        print("Update avatar success");
      }).catchError((error) => print("Failed to update avatar: $error"));
      StorageUtil.storeItem(StorageUtil.userProfile, Globals.user.value);
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future showRenameDialog() async {
    await this.showBottomSheet(
      child: RenameDialog(
        confirmAction: updateName,
      ),
    );
  }

  updateName(String name) {
    showLoading();
    userRepo
        .doc(Globals.user.value.id)
        .set(Globals.user.value.toJson())
        .then((value) {
      print("Update name success");
      closeLoading();
      Globals.user.value.name = name;
      Globals.user.refresh();
    }).catchError((error) => print("Failed to update name: $error"));
  }

  /// show dialog confirm logout
  void showLogoutDialog() {
    this.showDialogConfirm(
      title: Localizes.confirm.tr,
      content: Localizes.wantToLogout.tr,
      confirmText: Localizes.ok.tr,
      cancelText: Localizes.cancel.tr,
      confirmAction: this.logout,
      showOneButton: false,
      barrierDismissible: false,
      showIconClose: false,
    );
  }
}
