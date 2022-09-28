// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      deviceId: json['deviceId'],
      name: json['name'] as String?,
      password: json['password'] as String?,
      avatar: json['avatar'] as String?,
      joinedAt: json['joinedAt'],
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'name': instance.name,
      'avatar': instance.avatar,
      'accessToken': instance.accessToken,
      'password': instance.password,
      'joinedAt': instance.joinedAt,
    };
