// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      quotaMax: json['quota_max'] as int?,
      quotaRemaining: json['quota_remaining'] as int?,
      items: _$nullableGenericFromJson(json['items'], fromJsonT),
      hasMore: json['has_more'] as bool?,
      message: json['msg'] as String?,
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'msg': instance.message,
      'quota_remaining': instance.quotaRemaining,
      'quota_max': instance.quotaMax,
      'items': _$nullableGenericToJson(instance.items, toJsonT),
      'has_more': instance.hasMore,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
