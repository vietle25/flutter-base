// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      data: json['data'],
    )
      ..error = json['error']
      ..errorCode = json['errorCode'] as int?
      ..result = json['result'];

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'errorCode': instance.errorCode,
      'data': instance.data,
      'result': instance.result,
    };
