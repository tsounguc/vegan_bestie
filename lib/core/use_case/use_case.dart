import 'package:sheveegan/core/utils/typedefs.dart';

abstract class UseCase<T> {
  const UseCase();

  ResultFuture<T> call();
}

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class StreamUseCase<T> {
  const StreamUseCase();
  ResultStream<T> call();
}

abstract class StreamUseCaseWithParams<T, Params> {
  const StreamUseCaseWithParams();
  ResultStream<T> call(Params params);
}
