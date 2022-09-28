import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_base/controllers/login_controller.dart';
import 'package:flutter_base/locales/localizes.dart';
import 'package:flutter_base/models/common/app_bar_model.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/values/fonts.dart';
import 'package:flutter_base/values/images.dart';
import 'package:flutter_base/views/base/base_view.dart';
import 'package:flutter_base/widgets/button_widget.dart';
import 'package:flutter_base/widgets/hr_widget.dart';
import 'package:flutter_base/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class LoginView extends BaseView {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  PreferredSizeWidget? renderAppBar(
      {required BuildContext context, AppBarModel? appBarModel}) {
    return null;
  }

  @override
  Widget renderBody({BuildContext? context}) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraint.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Container(
                color: getTheme(context).backgroundColor,
                child: Column(
                  children: [
                    renderFormTextInput(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget renderFormTextInput() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: Constants.margin72, horizontal: Constants.padding12),
          child: Column(
            children: [
              TextFieldWidget(
                controller: _loginController.userNameTextController,
                labelText: Localizes.userName.tr,
                hintText: Localizes.userName.tr,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                margin: EdgeInsets.zero,
                containerDecoration: BoxDecoration(color: Colors.white),
              ),
              HrWidget(
                margin: EdgeInsets.only(
                    left: Constants.margin16, right: Constants.margin16),
              ),
              SizedBox(
                height: Constants.margin12 * 2,
              ),
              Obx(
                () => TextFieldWidget(
                  controller: _loginController.passwordTextController,
                  labelText: Localizes.password.tr,
                  hintText: Localizes.password.tr,
                  keyboardType: TextInputType.text,
                  obscureText: _loginController.hiddenPassword.value,
                  textInputAction: TextInputAction.next,
                  margin: EdgeInsets.zero,
                  suffixIcon: Image.asset(_loginController.hiddenPassword.value
                      ? Images.icEyeGray
                      : Images.icEyeHideGray),
                  containerDecoration: BoxDecoration(color: Colors.white),
                  onTapSuffix: () => _loginController.hiddenPassword.toggle(),
                ),
              ),
              HrWidget(
                margin: EdgeInsets.only(
                    left: Constants.margin16, right: Constants.margin16),
              ),
            ],
          ),
        ),
        ButtonWidget(
          title: Localizes.signIn.tr,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontSize: Fonts.font14,
          ),
          margin: const EdgeInsets.symmetric(
              vertical: Constants.margin16, horizontal: Constants.margin12 * 2),
          onTap: () {},
        )
      ],
    );
  }
}
