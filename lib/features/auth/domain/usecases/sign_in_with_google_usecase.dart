import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../entities/user_entity.dart';
import '../repositories_contracts/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _authRepositoryContract = serviceLocator<AuthRepository>();

  Future<Either<SignInWithGoogleFailure, UserEntity>> signInWithGoogle() {
    return _authRepositoryContract.signInWithGoogle();
  }
}
