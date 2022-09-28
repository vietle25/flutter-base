import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_base/controllers/register_controller.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/models/common/app_bar_model.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/values/extend_theme.dart';
import 'package:flutter_base/values/images.dart';
import 'package:flutter_base/views/base/base_view.dart';
import 'package:flutter_base/widgets/button_widget.dart';
import 'package:flutter_base/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class RegisterView extends BaseView {
  final RegisterController _controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  @override
  PreferredSizeWidget? renderAppBar(
      {required BuildContext context, AppBarModel? appBarModel}) {
    return null;
  }

  @override
  Widget renderBody({BuildContext? context}) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var theme = Theme.of(context!);
    final ExtendTheme extendTheme = Theme.of(context).extension<ExtendTheme>()!;
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: constraint.maxHeight -
                  MediaQuery.of(context).viewPadding.bottom),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              constraints: BoxConstraints(
                minHeight: Utils.getHeight(),
              ),
              color: theme.backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Image.asset(Images.imgChatBlue),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Localizes.register.tr,
                              style: CommonStyle.textXLargeBold(
                                      color: Colors.white)
                                  .merge(
                                const TextStyle(fontSize: 30),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              Localizes.registerDes.tr,
                              style:
                                  CommonStyle.textMedium(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      TextFieldWidget(
                        controller: _controller.nameTextController,
                        labelText: Localizes.yourName.tr,
                        hintText: Localizes.yourName.tr,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                        labelColor: theme.textTheme.bodyMedium?.color,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: extendTheme.hintColor,
                        ),
                        maxLength: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: Constants.margin16),
                        containerDecoration: BoxDecoration(
                          color: extendTheme.inputBackground,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      ButtonWidget(
                        circle: true,
                        margin: const EdgeInsets.fromLTRB(
                          Constants.margin16,
                          Constants.margin48,
                          Constants.margin16,
                          Constants.margin16,
                        ),
                        onTap: () {},
                        child: Icon(
                          Icons.navigate_next_rounded,
                          color: extendTheme.iconSecondColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
