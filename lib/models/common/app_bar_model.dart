import 'package:flutter/material.dart';

class AppBarModel {
  final bool isBack; // Is back
  final String? title; // Title
  final bool isBackground; // Is background
  final List<Widget>? actions; // Actions
  final Widget? titleWidget; // Title widget
  final Widget? iconBack;

  AppBarModel({
    required this.isBack,
    this.title,
    this.actions,
    this.isBackground = false,
    this.titleWidget,
    this.iconBack,
  });
}
