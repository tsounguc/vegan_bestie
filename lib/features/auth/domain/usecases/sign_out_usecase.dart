import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.main.dart';
import '../repositories_contracts/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _authRepositoryContract = serviceLocator<AuthRepository>();

  Future<Either<SignOutFailure, void>> signOut() {
    return _authRepositoryContract.signOut();
  }
}
