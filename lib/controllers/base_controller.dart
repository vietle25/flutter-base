import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_base/configs/error_code.dart';
import 'package:flutter_base/enums/language_code.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/models/user/user_model.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/router/router_config.dart';
import 'package:flutter_base/utils/date_util.dart';
import 'package:flutter_base/utils/storage_util.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/values/globals.dart';
import 'package:flutter_base/widgets/bottom_sheet_widget.dart';
import 'package:flutter_base/widgets/dialog_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:platform_device_id/platform_device_id.dart';

class BaseController extends GetxController {
  final chopperLogger = Logger(''); // Chopper logger
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserRepository? _userRepository = UserRepository.getInstance();
  final picker = ImagePicker(); // Create picker to choose image
  Rx<Null> bytes = null.obs;
  bool isShowDialogSession = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    // _firebaseMessaging.unsubscribeFromTopic(Constants.topicNotification);
  }

  /// Handle net work error
  handleNetWorkError(Object obj) {
    this.closeLoading();
    chopperLogger.info(obj);
    if (obj is SocketException) {
      // OSError osError = obj.osError;
      // handleError(osError.errorCode);

    } else {
      handleError(ErrorCode.common);
    }
  }

  /// Handle error
  handleError(int errorCode) {
    switch (errorCode) {
      case ErrorCode.missingParam:
      case ErrorCode.invalidParam:
      case ErrorCode.common:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.processingErr.tr,
        );
        break;
      case ErrorCode.dataNotFound:
        this.showDialogConfirm(
          title: Localizes.notification.tr,
          content: Localizes.dataNotFound.tr,
          confirmText: Localizes.back.tr,
          confirmAction: () => this.goBack(),
          showOneButton: true,
          barrierDismissible: false,
          showIconClose: false,
        );
        break;
      case ErrorCode.deactivate:
      case ErrorCode.unauthorised:
      case ErrorCode.sessionTimeout:
        break;
    }
  }

  /// Navigate to new screen with name.
  Future goTo(String router, [dynamic params]) async {
    this.navigatorPopOverlay();
    await Get.toNamed(router, arguments: params);
  }

  /// Navigate to new screen with name and bottom bar
  Future goToWithBottomBar(BuildContext context, String routerName) async {
    // await Get.toNamed(router, arguments: params);
    Globals.onNavigationPush(context, routerName);
  }

  /// Navigate and remove the previous screen from the tree.
  Future goToAndRemove(String router, [dynamic params]) async =>
      await Get.offNamed(router, arguments: params);

  /// Navigate and remove all previous screens from the tree.
  Future goToAndRemoveAll(String router, [dynamic params]) async =>
      await Get.offAllNamed(router, arguments: params);

  /// Go back
  Future goBack({BuildContext? context, result}) async {
    this.navigatorPopOverlay();
    if (!Utils.isNull(context)) {
      Navigator.pop(context!);
    } else {
      Get.back(result: result);
    }
  }

  /// Handle back
  Future<bool> handleBack() async {
    if (EasyLoading.isShow) {
      this.closeLoading();
    }
    return true;
  }

  /// Show dialog loading
  void showLoading() => EasyLoading.show();

  /// Close dialog loading
  void closeLoading() => EasyLoading.dismiss();

  /// Show dialog confirm
  Future showDialogConfirm({
    String? title,
    String? content,
    String? confirmText,
    String? cancelText,
    Function? cancelAction,
    Function? confirmAction,
    bool? showOneButton,
    bool? barrierDismissible,
    bool? showIconClose,
    TextStyle? titleStyle,
  }) async {
    await Get.dialog(
      WillPopScope(
        onWillPop:
            (() async => barrierDismissible!) as Future<bool> Function()?,
        child: DialogWidget(
          titleText: title,
          contentText: content,
          confirmText: confirmText,
          cancelText: cancelText,
          cancelAction: cancelAction as void Function()?,
          confirmAction: confirmAction as void Function()?,
          showOneButton: showOneButton ?? false,
          showIconClose: showIconClose ?? true,
          titleStyle: titleStyle,
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
    );
  }

  /// Show bottom sheet
  Future showBottomSheet({
    String? title,
    required Widget child,
    double? height,
    bool showIconClose = false,
    String? subTitle,
    bool? iconCloseRight,
    bool? expandChild,
    Function? onDismiss,
    bool isScrollControlled = true,
  }) async {
    await Get.bottomSheet(
      BottomSheetWidget(
        height: height,
        title: title,
        subTitle: subTitle,
        child: child,
        iconCloseRight: iconCloseRight,
        expandChild: false,
        onDismiss: onDismiss,
        showIconClose: showIconClose,
      ),
      isScrollControlled: isScrollControlled,
    );
  }

  /// Close snack bars, dialogs, bottom sheets, or anything you would normally
  void navigatorPopOverlay() {
    if (Get.isOverlaysOpen) Navigator.pop(Get.overlayContext!);
  }

  /// Show message
  showMessage({String? title, String? message}) {
    if (!Get.isOverlaysOpen)
      Get.snackbar(
        title ?? Localizes.notification.tr,
        message!,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(Constants.margin16),
        backgroundColor: Theme.of(Get.context!).bottomAppBarTheme.color,
        colorText: Theme.of(Get.context!).textTheme.bodyMedium?.color,
      );
  }

  /// Get device token
  Future<String?> getDeviceToken() async {
    try {
      String? deviceId = await PlatformDeviceId.getDeviceId;
      Globals.deviceToken = deviceId;
      await StorageUtil.storeItem(StorageUtil.deviceToken, deviceId);
      return deviceId;
    } on PlatformException {
      print('Failed to get platform version');
    } on MissingPluginException {
      print('Get device token error');
    }
    return null;
  }

  /// Get token firebase
  Future<String> getFirebaseToken() async {
    var token = "";
    // var token = await _firebaseMessaging.getToken();
    // Globals.firebaseToken = token;
    // await StorageUtil.storeItem(StorageUtil.deviceToken, token);
    return token;
  }

  /// Show date
  Future<DateTime?> showDate(
    DateTime selectedDate, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate ?? DateTime(1970),
      lastDate: lastDate ?? DateTime(2101),
      locale: LanguageCode.convertToLocale(Globals.language),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.primary,
            accentColor: Colors.primary,
            colorScheme: ColorScheme.light(primary: Colors.primary),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }

  /// Show time
  Future<TimeOfDay?> showTime(TimeOfDay selectedTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.primary,
            accentColor: Colors.primary,
            colorScheme: ColorScheme.light(primary: Colors.primary),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: Localizations.override(
            context: context,
            locale: LanguageCode.convertToLocale(Globals.language),
            child: child,
          ),
        );
      },
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }

  /// Log out
  Future<void> logout() async {
    this.showLoading();
    await StorageUtil.deleteItem(StorageUtil.userProfile);
    await StorageUtil.deleteItem(StorageUtil.firebaseToken);
    Globals.user.value = UserModel();
    Globals.firebaseToken = '';
    this.closeLoading();
    this.goToAndRemoveAll(RouterConfig.routeLogin);
    Future.delayed(Duration(milliseconds: 2000), () {
      this.isShowDialogSession = true;
    });
    // Delete database
  }

  /// Delete image network from cache to reload image
  Future deleteImageFromCache(String url) async {
    await CachedNetworkImage.evictFromCache(url);
  }

  /// Close keyboard
  void closeKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  uploadImage({required File file, required String name}) async {
    var date = DateUtil.now();
    var dateString = date.toString().split(" ")[0];
    String title = name;
    var titleSplit = title.split(".");
    String ext = titleSplit.last;
    title = titleSplit.join("_") + '_' + dateString + "." + ext;
    try {
      firebase_storage.TaskSnapshot task = await firebase_storage
          .FirebaseStorage.instance
          .ref('user/$title')
          .putFile(file);
      String path = await task.ref.getDownloadURL();
      return path;
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  /// Update language app
  void updateLanguage(String? language) async {
    Globals.language = language;
    await StorageUtil.storeItem(StorageUtil.language, language);
    List<String> values = Globals.language!.split('_');
    if (values.length > 1) {
      Get.updateLocale(Locale(values[0], values[1]));
    }
  }
}
