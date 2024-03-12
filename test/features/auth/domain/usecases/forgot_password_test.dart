import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/features/auth/domain/usecases/forgot_password.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repository;
  late ForgotPassword usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = ForgotPassword(repository);
  });

  test(
    'given the ForgotPassword use case '
    'when instantiated '
    'then call [RestaurantsRepository.forgotPassword] '
    'and return void',
    () async {
      when(
        () => repository.forgotPassword(
          email: any(named: 'email'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase('email');

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => repository.forgotPassword(
          email: 'email',
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
