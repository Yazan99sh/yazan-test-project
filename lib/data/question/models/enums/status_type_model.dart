import 'package:flutter_test_project/domain/question/entities/enums/status_type.dart';
import 'package:json_annotation/json_annotation.dart';

enum StatusTypeModel {
  @JsonValue('Pending')
  pending,
  @JsonValue('Accepted')
  accepted,
  @JsonValue('Rejected')
  rejected,
}

extension MapToDomain on StatusTypeModel {
  StatusType toDomain() => StatusType.values.firstWhere(
        (element) => element.name == name,
      );
}

StatusTypeModel statusTypeModelFromDomain(StatusType? type) {
  return StatusTypeModel.values
      .firstWhere((element) => element.name == type!.name);
}
