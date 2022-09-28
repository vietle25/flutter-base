import 'package:flutter/material.dart';

class HeaderModel {
  final TextEditingController? controller; // Controller text search bar
  String? title; // Title center search bar
  final TextStyle? titleStyle; // Title style
  bool? showIconAction; // Show icon action right
  bool? showLeadingButton; // Show leading button
  bool? isBackground; // Is background
  final Color? colorIcon; // Color icon

  HeaderModel({
    this.controller,
    this.title,
    this.titleStyle,
    this.showIconAction,
    this.showLeadingButton,
    this.isBackground,
    this.colorIcon,
  });
}
