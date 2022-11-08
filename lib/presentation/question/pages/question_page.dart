import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/domain/core/utils/network/network_info.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:flutter_test_project/injection.dart';
import 'package:flutter_test_project/presentation/core/blocs/core/base_paginated_list_state.dart';
import 'package:flutter_test_project/presentation/core/utils/save_data_localy.dart';
import 'package:flutter_test_project/presentation/core/widget/error_view.dart';
import 'package:flutter_test_project/presentation/core/widget/loader.dart';
import 'package:flutter_test_project/presentation/core/widget/shimmer.dart';
import 'package:flutter_test_project/presentation/question/blocs/question_list_bloc/question_list_bloc.dart';
import 'package:flutter_test_project/presentation/question/widgets/question_list_item_widgets/question_list_item_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final QuestionListBloc _questionListBloc = getIt<QuestionListBloc>();
  final RefreshController _refreshController = RefreshController();
  Future<void> checkConnection() async {
    bool connected = await InternetConnectionChecker().hasConnection;
    if (connected) {
      _requestData();
    } else {
      List<Question> questions = await SaveDataLocally.getSavedQuestion();
      print(questions.length);
      _questionListBloc.add(
        QuestionListLocallyRequested(questions: questions),
      );
    }
  }

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  void _requestData() {
    _questionListBloc.add(
      QuestionListRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('questions'.tr()),
      ),
      body: BlocBuilder<QuestionListBloc, BasePaginatedListState<Question>>(
        bloc: _questionListBloc,
        builder: (context, state) {
          if (state.isInProgress) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  itemCount: 10,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const ShimmerWidget(
                      width: double.infinity,
                      height: 160,
                      marginButton: 10,
                    );
                  }),
            );
          } else if (state.isFailure) {
            return SizedBox(
              height: 160,
              child: Center(
                child: ErrorView(
                  failure: state.failure,
                  onRetry: () {
                    _questionListBloc.add(QuestionListRequested());
                  },
                ),
              ),
            );
          }
          if (state.items.isEmpty) {
            return Center(
              child: Text('no_data'.tr()),
            );
          }
          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () {
              if (!state.hasReachedMax) {
                _questionListBloc.add(QuestionListPaginateRequested());
              }

              _refreshController.loadComplete();
            },
            onRefresh: () {
              _questionListBloc.add(QuestionListRequested());
            },
            header: MaterialClassicHeader(
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).cardTheme.color,
            ),
            footer: CustomFooter(
              height: state.status == PaginatedListStatus.paginateInProgress
                  ? 60
                  : 0,
              builder: (BuildContext context, LoadStatus? mode) {
                Widget footerBody;
                if (state.status == PaginatedListStatus.paginateInProgress) {
                  footerBody = const Loader();
                } else if (state.status ==
                    PaginatedListStatus.paginateFailure) {
                  footerBody = SizedBox(
                    height: 100,
                    child: Center(
                      child: ErrorView(
                        failure: state.failure,
                        onRetry: () {
                          if (!state.hasReachedMax) {
                            _questionListBloc
                                .add(QuestionListPaginateRequested());
                          }
                        },
                      ),
                    ),
                  );
                } else {
                  footerBody = const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Center(child: footerBody),
                );
              },
            ),
            child: ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return QuestionListItemWidget(
                    info: state.items[index],
                  );
                }),
          );
        },
      ),
    );
  }
}
