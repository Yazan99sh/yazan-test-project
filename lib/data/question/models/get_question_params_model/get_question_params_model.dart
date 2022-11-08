import 'package:flutter_test_project/data/core/models/base_pagination_params_model/base_pagination_params_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_question_params_model.g.dart';

@JsonSerializable(createToJson: true)
class GetQuestionParamsModel extends BasePaginationParamsModel {

  GetQuestionParamsModel({
    required int pageSize,
    required int page,
  }) : super(pageSize, page);

  @override
  Map<String, dynamic> toJson() => _$GetQuestionParamsModelToJson(this);
}
