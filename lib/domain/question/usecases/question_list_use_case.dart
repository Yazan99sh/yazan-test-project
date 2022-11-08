import 'package:dartz/dartz.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:flutter_test_project/domain/question/repositories/question_repository.dart';
import 'package:flutter_test_project/domain/core/entities/base_pagination_use_case_params.dart';
import 'package:flutter_test_project/domain/core/entities/failures.dart';
import 'package:flutter_test_project/domain/core/entities/paginated_list.dart';
import 'package:flutter_test_project/domain/core/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class QuestionListUseCase
    extends UseCase<PaginatedList<Question>, QuestionListUseCaseParams> {
  final QuestionRepository repository;

  QuestionListUseCase({required this.repository});

  @override
  Future<Either<Failure, PaginatedList<Question>>> call(
      QuestionListUseCaseParams params) {
    return repository.getQuestionsList(
        page: params.page ?? 1, pageSize: params.pageSize);
  }
}

class QuestionListUseCaseParams extends BasePaginationUseCaseParams {
  QuestionListUseCaseParams({
    required int page,
    required int pageSize,
  }) : super(pageSize, page);
}
