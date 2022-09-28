import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/styles/common_style.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/extend_theme.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Color? containerColor;
  final double? fontSize;
  final EdgeInsets? margin;
  final Decoration? containerDecoration;
  final Function? onFocus;
  final GestureTapCallback? onTap;
  final int? maxLength;
  final int? maxLines;
  final String? hintText;
  final bool obscureText;
  final TextStyle? style;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTapPrefix;
  final VoidCallback? onTapSuffix;
  final bool alignLabelWithHint;

  TextInputWidget({
    required this.controller,
    this.containerColor,
    this.fontSize,
    this.margin,
    this.containerDecoration,
    this.onFocus,
    this.onTap,
    this.maxLength,
    this.maxLines,
    this.hintText,
    this.obscureText = false,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapPrefix,
    this.onTapSuffix,
    this.alignLabelWithHint = false,
  });

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ExtendTheme extendTheme = Theme.of(context).extension<ExtendTheme>()!;
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: extendTheme.inputBackground,
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        cursorColor: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
        cursorHeight: (fontSize ?? 14),
        cursorWidth: 2,
        onChanged: (value) {
          if (maxLength != null && value.length <= maxLength!) {
            controller.text = value;
          }
        },
        style: style ??
            TextStyle(
              color: theme.textTheme.bodyMedium?.color,
              fontSize: fontSize ?? 14,
            ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: hintText ?? "",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          prefixIcon: !Utils.isNull(prefixIcon)
              ? renderButton(
                  context: context, icon: prefixIcon!, onTap: onTapPrefix!)
              : null,
          hintStyle: CommonStyle.text(color: extendTheme.hintColor).merge(
            TextStyle(fontSize: fontSize ?? 14),
          ),
          alignLabelWithHint: true,
          counterText: !Utils.isNull(controller) && !Utils.isNull(maxLength)
              ? '${controller.text.length}/$maxLength'
              : "",
        ),
      ),
    );
  }

  Widget renderButton(
      {required BuildContext context,
      required Widget icon,
      required VoidCallback onTap}) {
    final ExtendTheme extendTheme = Theme.of(context).extension<ExtendTheme>()!;
    return Material(
      color: extendTheme.inputBackground,
      child: InkWell(
        onTap: () {
          onTap();
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: icon,
      ),
    );
  }
}
