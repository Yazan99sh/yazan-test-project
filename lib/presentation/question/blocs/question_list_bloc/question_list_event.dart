part of 'question_list_bloc.dart';

@immutable
abstract class QuestionListEvent {}

class QuestionListRequested extends QuestionListEvent {
  final int? limit;
  final int? skip;
  QuestionListRequested({
    this.limit,
    this.skip,
  });
}

class QuestionListLocallyRequested extends QuestionListEvent {
  final List<Question> questions;
  QuestionListLocallyRequested({required this.questions});
}

class QuestionListPaginateRequested extends QuestionListEvent {}
