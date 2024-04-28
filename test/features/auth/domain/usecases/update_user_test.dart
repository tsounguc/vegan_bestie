import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/enums/update_user.dart';
import 'package:sheveegan/features/auth/domain/usecases/update_user.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repository;
  late UpdateUser usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = UpdateUser(repository);
    registerFallbackValue(UpdateUserAction.email);
  });

  test(
    'should call the [AuthRepo]',
    () async {
      when(
        () => repository.updateUser(
          action: any(named: 'action'),
          userData: any<dynamic>(named: 'userData'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(
        const UpdateUserParams(
          action: UpdateUserAction.email,
          userData: 'Test email',
        ),
      );

      expect(result, const Right<dynamic, void>(null));

      verify(
        () => repository.updateUser(
          action: UpdateUserAction.email,
          userData: 'Test email',
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
