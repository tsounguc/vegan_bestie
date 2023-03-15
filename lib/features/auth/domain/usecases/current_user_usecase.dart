import 'package:dartz/dartz.dart';

import '../../../../core/service_locator.dart';
import '../entities/user_entity.dart';
import '../repositories_contracts/auth_repository_contract.dart';

class CurrentUserUseCase {
  final AuthRepositoryContract _authRepositoryContract = serviceLocator<AuthRepositoryContract>();
  Future<Either<String, UserEntity>> currentUser() {
    return _authRepositoryContract.currentUser();
  }
}
