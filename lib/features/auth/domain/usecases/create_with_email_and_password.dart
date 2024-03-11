import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class CreateUserAccount extends UseCaseWithParams<void, CreateUserAccountParams> {
  const CreateUserAccount(this._repository);

  final AuthRepository _repository;

  @override
  ResultVoid call(CreateUserAccountParams params) {
    return _repository.createUserAccount(
      userName: params.userName,
      email: params.email,
      password: params.password,
    );
  }
}

class CreateUserAccountParams extends Equatable {
  const CreateUserAccountParams({
    required this.email,
    required this.password,
    required this.userName,
  });

  final String email;
  final String password;
  final String userName;

  @override
  List<Object?> get props => [
        email,
        password,
        userName,
      ];
}
