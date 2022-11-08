import 'package:dartz/dartz.dart';
import 'package:flutter_test_project/domain/core/entities/failures.dart';
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
