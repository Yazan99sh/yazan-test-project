import 'package:flutter_test_project/domain/question/entities/owner.dart';
import 'package:json_annotation/json_annotation.dart';
part 'owner_model.g.dart';

@JsonSerializable(createToJson: true)
class OwnerModel {
  @JsonKey(name: 'account_id')
  final int? accountId;
  @JsonKey(name: 'profile_image')
  final String profileImage;
  @JsonKey(name: 'display_name')
  final String displayName;
  OwnerModel(
    this.accountId,
    this.displayName,
    this.profileImage,
  );
  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);
}

extension MapToDomain on OwnerModel {
  Owner toDomain() => Owner(
        accountId: accountId ?? -1,
        displayName: displayName,
        profileImage: profileImage,
      );
}
