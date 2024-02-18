import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../repositories_contracts/auth_repository_contract.dart';

class SignOutUseCase {
  final AuthRepositoryContract _authRepositoryContract = serviceLocator<AuthRepositoryContract>();

  Future<Either<SignOutFailure, void>> signOut() {
    return _authRepositoryContract.signOut();
  }
}
