import 'package:dartz/dartz.dart';
import 'package:flutter_test_project/data/core/repositories/base_repository_impl.dart';
import 'package:flutter_test_project/data/question/datasource/remote/question_remote_datasource.dart';
import 'package:flutter_test_project/data/question/models/get_question_params_model/get_question_params_model.dart';
import 'package:flutter_test_project/data/question/models/question_model/question_model.dart';
import 'package:flutter_test_project/domain/question/entities/question.dart';
import 'package:flutter_test_project/domain/question/repositories/question_repository.dart';
import 'package:flutter_test_project/domain/core/entities/failures.dart';
import 'package:flutter_test_project/domain/core/entities/paginated_list.dart';
import 'package:flutter_test_project/domain/core/utils/network/network_info.dart';
import 'package:flutter_test_project/presentation/core/utils/save_data_localy.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: QuestionRepository)
class QuestionRepositoryImpl extends BaseRepositoryImpl
    implements QuestionRepository {
  final QuestionRemoteDataSource remote;
  final NetworkInfo networkInfo;
  final Logger logger;

  QuestionRepositoryImpl(
    this.logger,
    this.networkInfo,
    this.remote,
  ) : super(
          networkInfo,
          logger,
        );

  @override
  Future<Either<Failure, PaginatedList<Question>>> getQuestionsList({
    required int pageSize,
    required int page,
  }) async {
    return request(() async {
      final result = await remote.getQuestionsList(
        params: GetQuestionParamsModel(
          page: page,
          pageSize: pageSize,
        ),
      );
      await SaveDataLocally.saveData(result.items!);
      return Right(
        PaginatedList<Question>(
          result.quotaMax!,
          result.items!.map((e) => e.toDomain()).toList(),
        ),
      );
    });
  }

  @override
  Future<Either<Failure, Question>> getQuestionDetails(String id) async {
    return request(() async {
      final result = await remote.getQuestionDetails(id: id);
      return Right(result.items!.toDomain());
    });
  }
}
