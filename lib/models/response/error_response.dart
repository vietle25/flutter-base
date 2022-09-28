import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse implements Exception {
  @JsonKey(name: 'description')
  String? errorMessage;
  @JsonKey(name: 'errorCode')
  int? errorCode;

  ErrorResponse({this.errorCode, this.errorMessage});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
