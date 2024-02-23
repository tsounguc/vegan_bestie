import 'package:sheveegan/core/utils/typedefs.dart';

abstract class UseCase<T> {
  const UseCase();

  ResultFuture<T> call();
}

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}
