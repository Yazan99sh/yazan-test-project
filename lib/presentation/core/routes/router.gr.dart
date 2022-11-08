// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../../domain/question/entities/question.dart' as _i5;
import '../../question/pages/question_page.dart' as _i1;
import '../../question/pages/question_page_info.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    QuestionsPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.QuestionsPage());
    },
    QuestionPageInfoRoute.name: (routeData) {
      final args = routeData.argsAs<QuestionPageInfoRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.QuestionPageInfo(key: args.key, question: args.question));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(QuestionsPageRoute.name, path: '/'),
        _i3.RouteConfig(QuestionPageInfoRoute.name, path: '/question-page-info')
      ];
}

/// generated route for
/// [_i1.QuestionsPage]
class QuestionsPageRoute extends _i3.PageRouteInfo<void> {
  const QuestionsPageRoute() : super(QuestionsPageRoute.name, path: '/');

  static const String name = 'QuestionsPageRoute';
}

/// generated route for
/// [_i2.QuestionPageInfo]
class QuestionPageInfoRoute
    extends _i3.PageRouteInfo<QuestionPageInfoRouteArgs> {
  QuestionPageInfoRoute({_i4.Key? key, required _i5.Question question})
      : super(QuestionPageInfoRoute.name,
            path: '/question-page-info',
            args: QuestionPageInfoRouteArgs(key: key, question: question));

  static const String name = 'QuestionPageInfoRoute';
}

class QuestionPageInfoRouteArgs {
  const QuestionPageInfoRouteArgs({this.key, required this.question});

  final _i4.Key? key;

  final _i5.Question question;

  @override
  String toString() {
    return 'QuestionPageInfoRouteArgs{key: $key, question: $question}';
  }
}
