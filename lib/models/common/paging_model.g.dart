// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagingModel _$PagingModelFromJson(Map<String, dynamic> json) => PagingModel(
      page: json['page'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? Constants.pageSize,
    );

Map<String, dynamic> _$PagingModelToJson(PagingModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
