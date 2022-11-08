import 'package:flutter_test_project/data/question/models/owner_model/owner_model.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

@JsonSerializable(createToJson: true)
class QuestionModel {
  final List<String>? tags;
  final OwnerModel? owner;
  @JsonKey(name: 'is_answered')
  final bool? isAnswered;
  @JsonKey(name: 'view_count')
  final int? viewCount;
  @JsonKey(name: 'answer_count')
  final int? answerCount;
  @JsonKey(name: 'creation_date')
  final int creationDate;
  @JsonKey(name: 'question_id')
  final int questionId;
  final String title;
  final String link;
  QuestionModel(
    this.tags,
    this.owner,
    this.isAnswered,
    this.viewCount,
    this.answerCount,
    this.creationDate,
    this.questionId,
    this.title,
    this.link,
  );

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

extension MapToDomain on QuestionModel {
  Question toDomain() => Question(
        answerCount: answerCount ?? 0,
        creationDate: DateTime.fromMillisecondsSinceEpoch(creationDate * 1000),
        isAnswered: isAnswered ?? false,
        owner: owner?.toDomain(),
        questionId: questionId,
        tags: tags ?? [],
        viewCount: viewCount ?? 0,
        title: title,
        link: link,
      );
}
