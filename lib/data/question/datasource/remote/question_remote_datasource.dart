import 'package:flutter_test_project/data/core/models/base_response/base_response.dart';
import 'package:flutter_test_project/data/core/utils/configuration.dart';
import 'package:flutter_test_project/data/question/models/get_question_params_model/get_question_params_model.dart';
import 'package:flutter_test_project/data/question/models/question_model/question_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'question_remote_datasource.g.dart';

abstract class QuestionRemoteDataSource {
  Future<BaseResponse<List<QuestionModel>>> getQuestionsList({
    required GetQuestionParamsModel params,
  });

  Future<BaseResponse<QuestionModel>> getQuestionDetails({
    required String id,
  });
}

@LazySingleton(as: QuestionRemoteDataSource)
@RestApi(baseUrl: '')
abstract class QuestionRemoteDataSourceImpl
    implements QuestionRemoteDataSource {
  @factoryMethod
  factory QuestionRemoteDataSourceImpl(Dio dio, Configuration configuration) {
    return _QuestionRemoteDataSourceImpl(dio,
        baseUrl: configuration.getBaseUrl);
  }

  @override
  @GET('/questions?order=desc&sort=activity&site=stackoverflow')
  Future<BaseResponse<List<QuestionModel>>> getQuestionsList({
    @Queries() required GetQuestionParamsModel params,
  });
  @override
  @POST('/question/{id}')
  Future<BaseResponse<QuestionModel>> getQuestionDetails({
    @Path('id') required String id,
  });
}
