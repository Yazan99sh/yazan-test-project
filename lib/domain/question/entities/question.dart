import 'package:flutter_test_project/domain/question/entities/owner.dart';

class Question {
  List<String> tags;
  Owner? owner;
  bool isAnswered;
  int viewCount;
  int answerCount;
  DateTime creationDate;
  int questionId;
  String title;
  String link;
  Question({
    required this.tags,
    required this.owner,
    required this.isAnswered,
    required this.viewCount,
    required this.answerCount,
    required this.creationDate,
    required this.questionId,
    required this.title,
    required this.link,
  });
}
