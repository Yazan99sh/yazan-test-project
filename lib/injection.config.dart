// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
import 'package:location/location.dart' as _i6;
import 'package:logger/logger.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

import 'data/core/utils/configuration.dart' as _i3;
import 'data/core/utils/network/network_info.dart' as _i9;
import 'data/question/datasource/remote/question_remote_datasource.dart'
    as _i10;
import 'data/question/repositories/question_repository_impl.dart' as _i12;
import 'domain/core/utils/network/network_info.dart' as _i8;
import 'domain/question/repositories/question_repository.dart' as _i11;
import 'domain/question/usecases/question_list_use_case.dart' as _i14;
import 'injectable_module.dart' as _i16;
import 'presentation/question/blocs/question_list_bloc/question_list_bloc.dart'
    as _i15;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.lazySingleton<_i3.Configuration>(() => _i3.DevConfiguration(),
      registerFor: {_dev});
  gh.lazySingleton<_i3.Configuration>(() => _i3.StagingConfiguration(),
      registerFor: {_staging});
  gh.lazySingleton<_i3.Configuration>(() => _i3.ProductionConfiguration(),
      registerFor: {_prod});
  gh.lazySingleton<_i4.Dio>(() => injectableModule.dioInstance);
  gh.lazySingleton<_i5.InternetConnectionChecker>(
      () => injectableModule.connectionChecker);
  gh.lazySingleton<_i6.Location>(() => injectableModule.location);
  gh.lazySingleton<_i7.Logger>(() => injectableModule.logger);
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i9.NetworkInfoImpl(get<_i5.InternetConnectionChecker>()));
  gh.lazySingleton<_i10.QuestionRemoteDataSource>(() =>
      _i10.QuestionRemoteDataSourceImpl(
          get<_i4.Dio>(), get<_i3.Configuration>()));
  gh.lazySingleton<_i11.QuestionRepository>(() => _i12.QuestionRepositoryImpl(
      get<_i7.Logger>(),
      get<_i8.NetworkInfo>(),
      get<_i10.QuestionRemoteDataSource>()));
  await gh.lazySingletonAsync<_i13.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true);
  gh.lazySingleton<_i14.QuestionListUseCase>(() =>
      _i14.QuestionListUseCase(repository: get<_i11.QuestionRepository>()));
  gh.factory<_i15.QuestionListBloc>(
      () => _i15.QuestionListBloc(get<_i14.QuestionListUseCase>()));
  return get;
}

class _$InjectableModule extends _i16.InjectableModule {}
