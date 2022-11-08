import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:flutter_test_project/domain/question/usecases/question_list_use_case.dart';
import 'package:flutter_test_project/presentation/core/blocs/core/base_paginated_list_state.dart';
import 'package:injectable/injectable.dart';

part 'question_list_event.dart';

@injectable
class QuestionListBloc
    extends Bloc<QuestionListEvent, BasePaginatedListState<Question>> {
  final QuestionListUseCase questionListUseCase;
  late QuestionListUseCaseParams params;
  late int totalRecords;
  QuestionListBloc(
    this.questionListUseCase,
  ) : super(const BasePaginatedListState(
            status: PaginatedListStatus.inProgress)) {
    on<QuestionListLocallyRequested>(
      (event, emit) async {
        emit(
          const BasePaginatedListState(
            status: PaginatedListStatus.inProgress,
          ),
        );
        print('dsadSdaDdsadasd');
        emit(
          BasePaginatedListState(
              status: PaginatedListStatus.success,
              items: event.questions,
              hasReachedMax: true,
              totalRecords: event.questions.length),
        );
      },
    );

    on<QuestionListRequested>(
      (event, emit) async {
        emit(
          const BasePaginatedListState(
            status: PaginatedListStatus.inProgress,
          ),
        );
        params = QuestionListUseCaseParams(
          pageSize: event.limit ?? 5,
          page: event.skip ?? 1,
        );
        final result = await questionListUseCase(
          params,
        );
        result.fold(
          (l) => emit(
            BasePaginatedListState(
              status: PaginatedListStatus.failure,
              failure: l,
            ),
          ),
          (r) {
            totalRecords = r.totalRecords;
            emit(
              BasePaginatedListState(
                  status: PaginatedListStatus.success,
                  items: r.data,
                  hasReachedMax: r.data.length == r.totalRecords,
                  totalRecords: r.totalRecords),
            );
          },
        );
      },
    );

    on<QuestionListPaginateRequested>(
      (event, emit) async {
        if (state.items.length < totalRecords) {
          emit(state.copyWith(status: PaginatedListStatus.paginateInProgress));
          params.page = state.items.length;
          final result = await questionListUseCase(params);
          result.fold(
            (l) => emit(state.copyWith(
                status: PaginatedListStatus.paginateFailure, failure: l)),
            (r) {
              totalRecords = r.totalRecords;
              final items = state.items..addAll(r.data);
              emit(
                state.copyWith(
                  status: PaginatedListStatus.success,
                  items: items,
                  hasReachedMax: params.page == 25,
                ),
              );
            },
          );
        }
      },
    );
  }
}
