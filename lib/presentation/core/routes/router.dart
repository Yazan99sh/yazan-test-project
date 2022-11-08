import 'package:auto_route/annotations.dart';
import 'package:flutter_test_project/presentation/question/pages/question_page.dart';
import 'package:flutter_test_project/presentation/question/pages/question_page_info.dart';
export 'router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: QuestionsPage, initial: true),
    AutoRoute(page: QuestionPageInfo),
  ],
)
class $AppRouter {}
