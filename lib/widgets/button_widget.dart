import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/enums/enums.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';

import '../values/extend_theme.dart';

class ButtonWidget extends StatelessWidget {
  final ButtonType? type; // Type
  final Widget? child; // Child
  final double? radius; // Radius
  final Color? color; // Color
  final String title; // Title
  final TextStyle? titleStyle; // Title style
  final VoidCallback? onTap; // On tap
  final MainAxisSize? mainAxisSize; // Main axis size
  final EdgeInsets padding; // Padding
  final EdgeInsets? margin; // Margin
  final bool disable; // Disable button
  final bool circle; // circle
  final Widget? prefixIcon; // Prefix icon

  ButtonWidget({
    this.type,
    this.child,
    this.radius,
    this.color,
    this.titleStyle,
    this.disable = false,
    this.onTap,
    this.title: "",
    this.padding: const EdgeInsets.all(Constants.padding16),
    this.margin,
    this.mainAxisSize,
    this.prefixIcon,
    this.circle = false,
  });

  final borderRadius = BorderRadius.circular(Constants.cornerRadius);

  @override
  Widget build(BuildContext context) {
    switch (this.type) {
      case ButtonType.iconButton:
        return renderIconButton();
      default:
        return renderButtonNormal(context);
    }
  }

  /// Render icon button
  Widget renderIconButton() {
    return IconButton(
      onPressed: this.onTap,
      icon: this.child!,
    );
  }

  /// Render button normal
  Widget renderButtonNormal(BuildContext context) {
    final ExtendTheme extendTheme = Theme.of(context).extension<ExtendTheme>()!;
    return Container(
      margin: this.margin ??
          EdgeInsets.symmetric(
            horizontal: Constants.margin16,
            vertical: Constants.margin16,
          ),
      decoration: BoxDecoration(
        borderRadius: circle
            ? null
            : (!Utils.isNull(this.radius)
                ? BorderRadius.circular(this.radius!)
                : borderRadius),
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Material(
        color: this.color ?? extendTheme.buttonColor,
        borderRadius: circle
            ? null
            : (!Utils.isNull(this.radius)
                ? BorderRadius.circular(this.radius!)
                : borderRadius),
        shape: circle ? const CircleBorder() : null,
        child: InkWell(
          borderRadius: circle
              ? null
              : (!Utils.isNull(this.radius)
                  ? BorderRadius.circular(this.radius!)
                  : borderRadius),
          onTap: this.disable ? null : this.onTap ?? null,
          child: Container(
            padding: this.padding,
            decoration: BoxDecoration(
              borderRadius: circle
                  ? null
                  : (!Utils.isNull(this.radius)
                      ? BorderRadius.circular(this.radius!)
                      : borderRadius),
              shape: circle ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: circle
                      ? MainAxisSize.min
                      : (this.mainAxisSize ?? MainAxisSize.max),
                  children: [
                    !Utils.isNull(this.prefixIcon)
                        ? this.prefixIcon!
                        : Offstage(),
                    Text(
                      this.title.toString(),
                      style:
                          titleStyle ?? CommonStyle.text(color: Colors.white),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
