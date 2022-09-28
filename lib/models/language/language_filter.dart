import 'package:json_annotation/json_annotation.dart';

part 'language_filter.g.dart';

@JsonSerializable()
class LanguageFilter {
  String? language; // Language
  String? deviceToken; // Device token

  LanguageFilter({
    this.language,
    this.deviceToken,
  });

  Map<String, dynamic> toJson() => _$LanguageFilterToJson(this);
}
