import 'package:dartz/dartz.dart';

import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/services/service_locator.main.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/repositories_contracts/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _authRepositoryContract = serviceLocator<AuthRepository>();

  Future<Either<SignInWithGoogleFailure, UserEntity>> signInWithGoogle() {
    return _authRepositoryContract.signInWithGoogle();
  }
}
