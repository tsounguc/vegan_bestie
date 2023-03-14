import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../entities/user_entity.dart';
import '../repositories_contracts/auth_repository_contract.dart';

class CreateUserAccountUseCase {
  final AuthRepositoryContract _authRepositoryContract = serviceLocator<AuthRepositoryContract>();
  Future<Either<CreateWithEmailAndPasswordFailure, UserEntity>> createUserAccount(
      String userName, String email, String password) {
    return _authRepositoryContract.createUserAccount(userName, email, password);
  }
}
