import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/controllers/base_controller.dart';
import 'package:flutter_base/enums/enums.dart';
import 'package:flutter_base/enums/language_code.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/models/common/app_bar_model.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/values/extend_theme.dart';
import 'package:flutter_base/values/images.dart';
import 'package:flutter_base/widgets/button_widget.dart';
import 'package:get/get.dart';

class BaseView extends StatelessWidget {
  final BaseController _baseController = Get.put(BaseController());
  final List<Map<String, dynamic>> language = [
    {
      "id": LanguageCode.VI,
      "name": Localizes.vietnamese.tr,
      "icon": Images.icVietNamFlag
    },
    {
      "id": LanguageCode.EN,
      "name": Localizes.english.tr,
      "icon": Images.icEnglandFlag
    },
  ];

  // On will pop
  Future<bool> onWillPop() async {
    return _baseController.handleBack();
  }

  /// Go back
  Future goBack({BuildContext? context}) async {
    _baseController.goBack(context: context);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: renderAppBar(context: context),
        body: renderBody(context: context),
        resizeToAvoidBottomInset: true,
        floatingActionButton: renderFloatingButton(context: context),
      ),
    );
  }

  Widget? renderFloatingButton({required BuildContext context}) {
    return null;
  }

  PreferredSizeWidget? renderAppBar(
      {required BuildContext context, AppBarModel? appBarModel}) {
    final theme = Theme.of(context);
    return AppBar(
      leading: appBarModel!.isBack
          ? ButtonWidget(
              type: ButtonType.iconButton,
              onTap: () => goBack(context: context),
              child: appBarModel.iconBack ??
                  Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: theme.iconTheme.color,
                  ),
            )
          : null,
      centerTitle: false,
      // elevation: Constants.elevation,
      // shadowColor: Colors.shadow,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: appBarModel.isBack ? 4 : 16),
        child: Text(
          appBarModel.title ?? "Welcome",
          style: CommonStyle.textLargeBold(),
        ),
      ),
      titleSpacing: 0,
      actions: appBarModel.actions ?? [],
      backgroundColor: theme.backgroundColor,
      automaticallyImplyLeading: appBarModel.isBack ?? false,
    );
  }

  /// Render body
  Widget? renderBody({BuildContext? context}) {
    return null;
  }

  ThemeData getTheme(BuildContext context) => Theme.of(context);

  ExtendTheme getExtTheme(BuildContext context) =>
      Theme.of(context).extension<ExtendTheme>()!;
}
