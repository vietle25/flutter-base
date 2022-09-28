import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/controllers/profile_controller.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/models/common/app_bar_model.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/values/globals.dart';
import 'package:flutter_base/views/base/base_view.dart';
import 'package:flutter_base/widgets/button_widget.dart';
import 'package:flutter_base/widgets/image_loader_widget.dart';
import 'package:flutter_base/widgets/list_view_widget.dart';
import 'package:get/get.dart';

class ProfileView extends BaseView {
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  /// Render app bar
  @override
  @override
  PreferredSizeWidget? renderAppBar(
      {required BuildContext context, AppBarModel? appBarModel}) {
    return super.renderAppBar(
      context: context,
      appBarModel: AppBarModel(
        isBack: true,
        title: "",
      ),
    );
  }

  /// Render body login
  @override
  Widget renderBody({BuildContext? context}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context!).requestFocus(FocusNode()),
      child: Container(
        color: getTheme(context!).backgroundColor,
        height: Utils.getHeight(),
        width: Utils.getWidth(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: Constants.padding16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              renderAccount(),
              SizedBox(
                height: Constants.margin48,
              ),
              renderFunctions(context),
              SizedBox(
                height: Constants.margin24,
              ),
              renderVersion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => ButtonWidget(
              onTap: _controller.pickImage,
              color: Colors.transparent,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: ImageLoaderWidget(
                heightImage: 82,
                widthImage: 82,
                boxFit: BoxFit.cover,
                imageUrl: Globals.user.value.avatar ?? "",
              ),
            ),
          ),
          SizedBox(
            width: Constants.margin20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  Globals.user.value.name ?? "User name",
                  style: CommonStyle.textXLargeBold(),
                ),
              ),
              SizedBox(
                width: Constants.margin8,
              ),
              ButtonWidget(
                onTap: _controller.showRenameDialog,
                color: Colors.transparent,
                padding: EdgeInsets.all(Constants.padding),
                margin: EdgeInsets.zero,
                child: Icon(Icons.edit, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderFunctions(BuildContext context) {
    return Column(
      children: [
        ButtonWidget(
          onTap: () {
            showDialogChangeLanguage(context: context);
          },
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: Constants.padding12,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: Constants.margin16,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: getTheme(context).iconTheme.color!,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: Constants.padding8),
            child: Row(
              children: [
                Icon(
                  Icons.language,
                  color: getTheme(context).iconTheme.color,
                ),
                SizedBox(
                  width: Constants.margin16,
                ),
                Text(
                  Localizes.changeLanguage.tr,
                  style: CommonStyle.text(),
                ),
              ],
            ),
          ),
        ),
        ButtonWidget(
          onTap: _controller.showLogoutDialog,
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: Constants.padding12,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: Constants.margin16,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: getTheme(context).iconTheme.color!,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: Constants.padding8),
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: getTheme(context).iconTheme.color,
                ),
                SizedBox(
                  width: Constants.margin16,
                ),
                Text(
                  Localizes.logout.tr + ", " + Localizes.deleteData.tr,
                  style: CommonStyle.text(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Show dialog chang language
  showDialogChangeLanguage({BuildContext? context}) {
    _controller.showBottomSheet(
      height: 160,
      title: Localizes.changeLanguage.tr,
      child: ListViewWidget(
        shrinkWrap: true,
        itemCount: language.length,
        margin: EdgeInsets.all(Constants.margin16),
        decoration: BoxDecoration(
          color: getTheme(context!).backgroundColor,
          borderRadius: BorderRadius.circular(Constants.cornerRadius),
        ),
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _controller.updateLanguage(language[index]['id']);
                Navigator.of(context).pop();
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: index == 0 ? 0 : Constants.margin16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(language[index]['icon']),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Constants.margin16,
                          ),
                          child: Text(
                            language[index]['name'],
                            style: CommonStyle.text(),
                          ),
                        ),
                      ],
                    ),
                    Globals.language == language[index]['id']
                        ? Icon(
                            Icons.radio_button_checked_outlined,
                            color: getTheme(context).iconTheme.color,
                          )
                        : Icon(
                            Icons.radio_button_off_outlined,
                            color: getTheme(context).iconTheme.color,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //Render version
  Widget renderVersion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Constants.margin),
      alignment: Alignment.center,
      child: Obx(() => Text(
            Localizes.creditApp.tr + ': ' + _controller.versionApp.toString(),
            style: CommonStyle.textSmall(),
          )),
    );
  }
}
