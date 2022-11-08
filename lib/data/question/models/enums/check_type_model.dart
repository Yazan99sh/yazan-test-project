import 'package:flutter_test_project/domain/question/entities/enums/check_type.dart';
import 'package:json_annotation/json_annotation.dart';

enum CheckTypeModel {
  @JsonValue('Tablet')
  tablet,
  @JsonValue('Mobile')
  mobile,
  @JsonValue('Admin')
  admin,
  @JsonValue('Automated')
  automated,
}

extension MapToDomain on CheckTypeModel {
  CheckType toDomain() => CheckType.values.firstWhere(
        (element) => element.name == name,
      );
}

CheckTypeModel? checkTypeModelFromDomain(CheckType? type) {
  if (type == null) return null;
  return CheckTypeModel.values
      .firstWhere((element) => element.name == type.name);
}
