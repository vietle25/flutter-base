import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/utils/string_util.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/values/globals.dart';
import 'package:flutter_base/views/base/item_mixin.dart';
import 'package:flutter_base/widgets/button_widget.dart';
import 'package:flutter_base/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class RenameDialog extends StatefulWidget {
  final Function? confirmAction;

  RenameDialog({
    this.confirmAction,
  });

  @override
  RenameDialogState createState() => RenameDialogState();
}

class RenameDialogState extends State<RenameDialog> with ItemMixin {
  TextEditingController? nameCtl;
  String? error;

  @override
  void initState() {
    super.initState();
    nameCtl = TextEditingController(text: Globals.user.value.name);
  }

  @override
  Widget build(BuildContext context) {
    return this.renderBody(context);
  }

  validate() {
    if (Utils.isNull(nameCtl!.text)) {
      setState(() {
        error = Localizes.pleaseEnter(Localizes.yourName.tr.toLowerCase());
      });
    } else if (StringUtil.hasSpecialCharacter(nameCtl!.text)) {
      setState(() {
        error = Localizes.nameMustDontHaveSpecialChar.tr;
      });
    } else if (nameCtl!.text.length > 50) {
      setState(() {
        error = Localizes.maxLength(Localizes.yourName.tr.toLowerCase(), 50);
      });
    } else {
      widget.confirmAction!(nameCtl!.text);
      Navigator.of(Get.context!).pop();
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  /// Render body
  Widget renderBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: getTheme(context).backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Constants.padding16 + Constants.margin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    Localizes.updateName.tr,
                    style: CommonStyle.textLargeBold(),
                    textAlign: TextAlign.left,
                  ),
                ),
                renderCloseButton(),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                controller: nameCtl,
                labelText: Localizes.yourName.tr,
                hintText: Localizes.yourName.tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: CommonStyle.textMedium(),
                labelColor: getTheme(context)
                    .textTheme
                    .bodyMedium
                    ?.color!
                    .withOpacity(0.7),
                margin: EdgeInsets.symmetric(
                    horizontal: Constants.margin16,
                    vertical: Constants.margin8),
                containerDecoration: BoxDecoration(
                    color: getExtTheme(context).inputBackground,
                    borderRadius: BorderRadius.circular(8)),
                maxLength: 50,
                onChanged: (value) {
                  if (!Utils.isNull(error)) {
                    setState(() {
                      error = null;
                    });
                  }
                  // return value;
                },
              ),
              SizedBox(
                height: Constants.margin8,
              ),
              Utils.isNull(error)
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.padding16),
                      child: Text(
                        error!,
                        style: CommonStyle.textSmall(),
                      ),
                    ),
            ],
          ),
          ButtonWidget(
            titleStyle: CommonStyle.textBold(color: Colors.white),
            title: Localizes.ok.tr,
            padding: EdgeInsets.symmetric(
                horizontal: Constants.padding24, vertical: Constants.padding16),
            onTap: () {
              validate();
            },
            margin: EdgeInsets.only(
              top: Constants.margin16,
              bottom: Constants.margin24,
              left: Constants.margin16,
              right: Constants.margin16,
            ),
          ),
        ],
      ),
    );
  }

  // Returns the close button on the top right
  Widget renderCloseButton() {
    return ButtonWidget(
      mainAxisSize: MainAxisSize.min,
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      prefixIcon: Icon(Icons.close),
      onTap: this.onTapClose,
    );
  }

  /// On tap close
  onTapClose() {
    Navigator.of(Get.context!).pop();
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
