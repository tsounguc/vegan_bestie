import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../entities/user_entity.dart';
import '../repositories_contracts/auth_repository_contract.dart';

class SignInWithFacebookUseCase {
  final AuthRepositoryContract _authRepositoryContract = serviceLocator<AuthRepositoryContract>();
  Future<Either<SignInWithFacebookFailure, UserEntity>> signInWithFacebook() {
    return _authRepositoryContract.signInWithFacebook();
  }
}
