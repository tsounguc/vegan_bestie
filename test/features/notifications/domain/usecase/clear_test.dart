import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:sheveegan/features/notifications/domain/usecases/clear.dart';

import 'notification_repository.mock.dart';

void main() {
  late NotificationRepository repository;
  late Clear useCase;

  setUp(() {
    repository = MockNotificationRepository();
    useCase = Clear(repository);
  });

  test(
    'given Clear use case '
    'when instantiated '
    'then [NotificationRepository.clear] should be called',
    () async {
      // Arrange
      when(() => repository.clear(any())).thenAnswer(
        (_) async => const Right(null),
      );

      // Act
      final result = await useCase('id');

      // Assert
      verify(() => repository.clear('id')).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
