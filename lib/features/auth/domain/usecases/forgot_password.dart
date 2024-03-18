import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repository);

  final AuthRepository _repository;

  @override
  ResultVoid call(String params) => _repository.forgotPassword(
        email: params,
      );
}
