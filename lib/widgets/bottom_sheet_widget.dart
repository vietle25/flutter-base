import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/views/base/item_mixin.dart';
import 'package:flutter_base/widgets/button_widget.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends StatelessWidget with ItemMixin {
  final String? title; // Title text
  final String? subTitle; // Title text
  final TextStyle? titleStyle; // Title style
  final bool showIconClose; // Show icon close
  final bool expandChild; // Show icon close
  final Widget? child; // Child
  final double? height;
  final bool? iconCloseRight;
  final Function? onDismiss;

  BottomSheetWidget({
    this.title,
    this.subTitle,
    this.titleStyle,
    this.showIconClose = false,
    this.expandChild = false,
    this.child,
    this.height,
    this.onDismiss,
    this.iconCloseRight = true,
  });

  @override
  Widget build(BuildContext context) {
    return this.renderBody(context);
  }

  /// Render body
  Widget renderBody(BuildContext context) {
    return SafeArea(
      child: Container(
        height: this.height,
        decoration: BoxDecoration(
          color: getTheme(context).backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Constants.cornerRadius),
            topRight: Radius.circular(Constants.cornerRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (Utils.isNull(title) && !showIconClose)
                ? Container()
                : Container(
                    padding: EdgeInsets.all(Constants.padding16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (!(iconCloseRight ?? false))
                            ? renderCloseButton()
                            : Container(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              title ?? Localizes.notification.tr,
                              style: titleStyle ?? CommonStyle.textMediumBold(),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: Constants.margin,
                            ),
                            Utils.isNull(subTitle)
                                ? Container()
                                : Text(
                                    subTitle!,
                                    style: CommonStyle.textSmall(
                                        color: Colors.grey600),
                                    textAlign: TextAlign.center,
                                  ),
                          ],
                        ),
                        ((iconCloseRight ?? false))
                            ? renderCloseButton()
                            : Container(),
                      ],
                    ),
                  ),
            if (expandChild) Expanded(child: this.child ?? Container()),
            if (!expandChild) this.child ?? Container()
          ],
        ),
      ),
    );
  }

  // Returns the close button on the top right
  Widget renderCloseButton() {
    return showIconClose
        ? ButtonWidget(
            margin: EdgeInsets.zero,
            color: Colors.transparent,
            child: Icon(Icons.close),
            onTap: this.onTapClose,
          )
        : Container();
  }

  /// On tap close
  onTapClose() {
    Navigator.of(Get.context!, rootNavigator: true).pop();
    if (onDismiss != null) {
      onDismiss!();
    }
  }
}
