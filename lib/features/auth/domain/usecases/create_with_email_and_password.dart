import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class CreateUserAccount extends UseCaseWithParams<UserEntity, CreateUserAccountParams> {
  const CreateUserAccount(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<UserEntity> call(CreateUserAccountParams params) {
    return _repository.createUserAccount(
      userName: params.fullName,
      email: params.email,
      password: params.password,
    );
  }
}

class CreateUserAccountParams extends Equatable {
  const CreateUserAccountParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const CreateUserAccountParams.empty()
      : this(
          email: '',
          password: '',
          fullName: '',
        );

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [
        email,
        password,
        fullName,
      ];
}
