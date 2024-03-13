import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/usecases/create_with_email_and_password.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repository;
  late CreateUserAccount useCase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tUserName = 'Test userName';

  setUp(() {
    repository = MockAuthRepo();
    useCase = CreateUserAccount(repository);
  });

  const tUser = UserEntity.empty();
  final testFailure = CreateWithEmailAndPasswordFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the CreateUserAccount use case '
    'when instantiated '
    'then call [AuthRepository.createUserAccount] '
    'and return [UserEntity]',
    () async {
      when(
        () => repository.createUserAccount(
            email: any(named: 'email'), password: any(named: 'password'), userName: any(named: 'userName')),
      ).thenAnswer((_) async => const Right(tUser));

      final result = await useCase(
        const CreateUserAccountParams(
          email: tEmail,
          password: tPassword,
          userName: tUserName,
        ),
      );

      expect(result, const Right<dynamic, UserEntity>(tUser));

      verify(
        () => repository.createUserAccount(
          email: tEmail,
          password: tPassword,
          userName: tUserName,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the CreateUserAccount use case '
    'when instantiated '
    'and call [AuthRepository.createUserAccount] is unsuccessful '
    'then return [SignInWithEmailAndPasswordFailure]',
    () async {
      // Arrange
      when(
        () => repository.createUserAccount(
          email: any(named: 'email'),
          password: any(named: 'password'),
          userName: any(named: 'userName'),
        ),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(
        const CreateUserAccountParams(
          email: tEmail,
          password: tPassword,
          userName: tUserName,
        ),
      );
      // Assert
      expect(
        result,
        Left<Failure, UserEntity>(testFailure),
      );
      verify(
        () => repository.createUserAccount(
          email: tEmail,
          password: tPassword,
          userName: tUserName,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
