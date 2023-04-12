import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../entities/user_entity.dart';
import '../repositories_contracts/auth_repository_contract.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepositoryContract _authRepositoryContract = serviceLocator<AuthRepositoryContract>();
  Future<Either<SignInWithEmailAndPasswordFailure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) {
    return _authRepositoryContract.signInWithEmailAndPassword(email, password);
  }
}