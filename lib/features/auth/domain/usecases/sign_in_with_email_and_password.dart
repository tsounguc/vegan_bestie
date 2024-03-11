import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmailAndPassword extends UseCaseWithParams<UserEntity, SignInParams> {
  const SignInWithEmailAndPassword(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<UserEntity> call(
    SignInParams params,
  ) =>
      _repository.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : this(
          email: '',
          password: '',
        );

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
