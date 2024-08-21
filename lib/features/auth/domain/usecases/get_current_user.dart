import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

// class GetCurrentUser extends StreamUseCaseWithParams<UserEntity, String> {
//   const GetCurrentUser(this._repository);
//
//   final AuthRepository _repository;
//
//   @override
//   ResultStream<UserEntity> call(String params) => _repository.getCurrentUser(userId: params);
// }

class GetCurrentUser extends UseCase<UserEntity> {
  const GetCurrentUser(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<UserEntity> call() => _repository.currentUser();
}
