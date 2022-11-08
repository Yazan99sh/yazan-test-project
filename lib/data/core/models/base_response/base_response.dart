import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'msg')
  final String? message;
  @JsonKey(name: 'quota_remaining')
  final int? quotaRemaining;
  @JsonKey(name: 'quota_max')
  final int? quotaMax;
  final T? items;
  @JsonKey(name: 'has_more')
  final bool? hasMore;

  BaseResponse({
    this.quotaMax,
    this.quotaRemaining,
    this.items,
    this.hasMore,
    this.message,
  });

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);
}
