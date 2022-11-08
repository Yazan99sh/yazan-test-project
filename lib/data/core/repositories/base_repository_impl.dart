import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test_project/data/core/models/base_response/base_response.dart';
import 'package:flutter_test_project/domain/core/entities/failures.dart';
import 'package:flutter_test_project/domain/core/repositories/base_repository.dart';
import 'package:flutter_test_project/domain/core/utils/constants.dart';
import 'package:flutter_test_project/domain/core/utils/network/network_info.dart';
import 'package:logger/logger.dart';

class BaseRepositoryImpl implements BaseRepository {
  // final AuthRemoteDataSource _authRemote = getIt<AuthRemoteDataSource>();
  final NetworkInfo _networkInfo;
  final Logger _logger;

  BaseRepositoryImpl(this._networkInfo, this._logger);

  @override
  Future<Either<Failure, T>> request<T>(
    FutureEitherFailureOrData<T> body,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return left(
            ServerFailure(errorCode: ServerErrorCode.noInternetConnection));
      }
      return await body();
    } catch (e) {
      if (e is DioError) {
        _logger.e(e.message, e, e.stackTrace);

        var message = '';
        var errorCode = ServerErrorCode.serverError;

        if (e.response != null) {
          errorCode = _getErrorCode(e.response!.statusCode ?? 500);

          try {
            final responseData = e.response!.data is String
                ? jsonDecode(e.response!.data)
                : e.response!.data;
            final baseResponse =
                BaseResponse.fromJson(responseData, (_) => null);
            message = baseResponse.message ?? '';
            return left(
              ServerFailure(
                errorCode: errorCode,
                message: message,
              ),
            );
          } catch (e) {
            return left(
              ServerFailure(
                errorCode: errorCode,
                message: message,
              ),
            );
          }
        }
      } else if (e is Error) {
        _logger.e(e.toString(), e, e.stackTrace);
      } else {
        _logger.e(e);
      }

      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }

  ServerErrorCode _getErrorCode(int statusCode) {
    switch (statusCode) {
      case 401:
        return ServerErrorCode.unauthenticated;
      case 404:
        return ServerErrorCode.notFound;
      case 403:
        return ServerErrorCode.forbidden;
      default:
        return ServerErrorCode.serverError;
    }
  }
}
