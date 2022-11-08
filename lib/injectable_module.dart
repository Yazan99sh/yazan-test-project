import 'dart:async';
import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (statusCode) {
            if (statusCode != null) {
              if (200 <= statusCode && statusCode < 300) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          }),
    );

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (obj) {
          debugPrint(obj.toString());
        },
      ),
    );
    final cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.forceCache,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.high,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          Map<String, String> headers;
          // final failureOrToken = await getIt<AuthRepository>().getAccessToken();
          // final accessToken = failureOrToken.getOrElse(() => null);
          // if (accessToken != null) {
          //   headers = {'Authorization': 'Bearer $accessToken'};
          //   request.headers.addAll(headers);
          // }
          final key = CacheOptions.defaultCacheKeyBuilder(request);
          final cache = await MemCacheStore().get(key);
          log('--------------------------$cache');

          if (cache != null) {
            log('There is a cash ........');
            return handler
                .resolve(cache.toResponse(request, fromNetwork: false));
          }
          request.sendTimeout = 60000;
          request.connectTimeout = 60000;
          request.receiveTimeout = 60000;
          return handler.next(request);
        },
      ),
    );
    dio.interceptors.add(CurlLoggerDioInterceptor());
    return dio;
  }

  @lazySingleton
  Logger get logger => Logger();

  @lazySingleton
  Location get location => Location();
}
