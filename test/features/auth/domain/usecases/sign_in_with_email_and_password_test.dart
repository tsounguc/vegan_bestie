import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/usecases/sign_in_with_email_and_password.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repository;
  late SignInWithEmailAndPassword useCase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repository = MockAuthRepo();
    useCase = SignInWithEmailAndPassword(repository);
  });

  const tUser = UserEntity.empty();
  const testFailure = SignInWithEmailAndPasswordFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the SignInWithEmailAndPassword use case '
    'when instantiated '
    'then call [AuthRepository.getRestaurantsNearMe] '
    'and return [UserEntity]',
    () async {
      when(
        () => repository.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(tUser));

      final result = await useCase(
        const SignInParams(
          email: tEmail,
          password: tPassword,
        ),
      );

      expect(result, const Right<dynamic, UserEntity>(tUser));

      verify(
        () => repository.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the SignInWithEmailAndPassword use case '
    'when instantiated '
    'and call [AuthRepository.getRestaurantsNearMe] is unsuccessful '
    'then return [SignInWithEmailAndPasswordFailure]',
    () async {
      // Arrange
      when(
        () => repository.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(testFailure));
      // Act
      final result = await useCase(
        const SignInParams(
          email: tEmail,
          password: tPassword,
        ),
      );
      // Assert
      expect(
        result,
        const Left<Failure, UserEntity>(testFailure),
      );
      verify(
        () => repository.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
