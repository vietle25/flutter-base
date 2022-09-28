import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/views/base/item_mixin.dart';
import 'package:flutter_base/widgets/button_widget.dart';
import 'package:get/get.dart';

class DialogWidget extends StatelessWidget with ItemMixin {
  final String? titleText; // Title text
  final TextStyle? titleStyle; // Title style
  final String? contentText; // Content text
  final TextStyle? contentStyle; // Content style
  final String? confirmText; // Confirm text
  final String? cancelText; // Cancel text
  final VoidCallback? confirmAction; // Confirm action
  final VoidCallback? cancelAction; // Cancel action
  final Color colorButtonOne; // Color button one
  final Color? colorButtonTwo; // Color button two
  final bool showIconClose; // Show icon close
  final bool showOneButton; // Show one button

  DialogWidget({
    this.titleText,
    this.titleStyle,
    this.contentText = "",
    this.contentStyle,
    this.cancelText = "",
    this.confirmText = "",
    this.confirmAction,
    this.cancelAction,
    this.colorButtonOne = Colors.grey,
    this.colorButtonTwo,
    this.showIconClose = true,
    this.showOneButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(Constants.padding16 * 2),
      backgroundColor: getTheme(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.cornerRadius),
      ),
      child: this.renderBody(),
    );
  }

  /// Render body
  Widget renderBody() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          !Utils.isNull(titleText) && !showIconClose
              ? Padding(
                  padding: EdgeInsets.only(
                    top: !showIconClose ? Constants.margin16 : 0,
                    bottom: !showIconClose ? Constants.margin16 : 0,
                    left: Constants.padding16 + Constants.margin,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          titleText ?? Localizes.notification.tr,
                          style: titleStyle ?? CommonStyle.textBold(),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      renderCloseButton(),
                    ],
                  ),
                )
              : SizedBox(
                  height: Constants.margin16,
                ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: Constants.padding16,
              left: Constants.padding16 + Constants.margin,
              right: Constants.padding16 + Constants.margin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    contentText ?? "",
                    style: contentStyle ?? CommonStyle.text(),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!this.showOneButton)
                ButtonWidget(
                  color: Colors.transparent,
                  titleStyle: CommonStyle.textBold(),
                  title: cancelText ?? Localizes.cancel.tr,
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                  onTap: this.onTapClose,
                  margin: EdgeInsets.only(
                    top: Constants.margin16,
                  ),
                ),
              ButtonWidget(
                color: Colors.transparent,
                titleStyle: CommonStyle.textBold(),
                title: confirmText ?? Localizes.ok.tr,
                padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                onTap: () {
                  Navigator.of(Get.context!).pop();
                  FocusManager.instance.primaryFocus!.unfocus();
                  if (!Utils.isNull(confirmAction)) confirmAction!();
                },
                margin: EdgeInsets.only(
                  top: Constants.margin16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Returns the close button on the top right
  Widget renderCloseButton() {
    return showIconClose
        ? ButtonWidget(
            mainAxisSize: MainAxisSize.min,
            margin: EdgeInsets.zero,
            color: Colors.transparent,
            prefixIcon: Icon(Icons.close),
            onTap: this.onTapClose,
          )
        : Container();
  }

  /// On tap close
  onTapClose() {
    Navigator.of(Get.context!).pop();
    FocusManager.instance.primaryFocus!.unfocus();
    if (!Utils.isNull(cancelAction)) cancelAction!();
  }
}
