import 'package:dartz/dartz.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:flutter_test_project/domain/core/entities/failures.dart';
import 'package:flutter_test_project/domain/core/entities/paginated_list.dart';
import 'package:flutter_test_project/domain/core/repositories/base_repository.dart';

abstract class QuestionRepository extends BaseRepository {
  Future<Either<Failure, PaginatedList<Question>>> getQuestionsList({
    required int pageSize,
    required int page,
  });
}
