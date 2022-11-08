// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['owner'] == null
          ? null
          : OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
      json['is_answered'] as bool?,
      json['view_count'] as int?,
      json['answer_count'] as int?,
      json['creation_date'] as int,
      json['question_id'] as int,
      json['title'] as String,
      json['link'] as String,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'owner': instance.owner,
      'is_answered': instance.isAnswered,
      'view_count': instance.viewCount,
      'answer_count': instance.answerCount,
      'creation_date': instance.creationDate,
      'question_id': instance.questionId,
      'title': instance.title,
      'link': instance.link,
    };
