import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const CustomDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;

    if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }
    return null;
  }

  @override
  String? toJson(DateTime? json) => json?.toUtc().toIso8601String();
}
