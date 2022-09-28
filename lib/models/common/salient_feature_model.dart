import 'package:flutter/material.dart';

class SalientFeatureModel {
  String? name;
  String? icon;
  Color? color;
  String? routeName;

  SalientFeatureModel({this.name, this.icon, this.color, this.routeName});

  factory SalientFeatureModel.fromJson(Map<String, dynamic> map) {
    return SalientFeatureModel(
      name: map['name'] as String?,
      icon: map['icon'] as String?,
      color: map['color'] as Color?,
      routeName: map['routeName'] as String?,
    );
  }
}
