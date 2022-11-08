import 'dart:convert';

import 'package:flutter_test_project/data/core/utils/constants.dart';
import 'package:flutter_test_project/data/question/models/question_model/question_model.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveDataLocally {
  static Future<void> saveData(List<QuestionModel> models) async {
    String encoded = json.encode(models.map((e) => e.toJson()).toList());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SharedPreferencesKeys.questions, encoded);
    return;
  }

  static Future<List<Question>> getSavedQuestion() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? encoded =
        sharedPreferences.getString(SharedPreferencesKeys.questions);
    if (encoded == null) {
      return [];
    }
    List<QuestionModel> questionModel = [];
    try {
      (json.decode(encoded) as List<dynamic>).forEach((element) {
        questionModel.add(QuestionModel.fromJson(element));
      });
    } catch (e) {
      print(e);
    }
    return questionModel.map((e) => e.toDomain()).toList();
  }
}
