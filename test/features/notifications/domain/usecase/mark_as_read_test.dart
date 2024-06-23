import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:sheveegan/features/notifications/domain/usecases/mark_as_read.dart';

import 'notification_repository.mock.dart';

void main() {
  late NotificationRepository repository;
  late MarkAsRead useCase;

  setUp(() {
    repository = MockNotificationRepository();
    useCase = MarkAsRead(repository);
  });

  test(
    'given MarkAsRead use case '
    'when instantiated '
    'then [NotificationRepository.markAsRead] should be called',
    () async {
      // Arrange
      when(() => repository.markAsRead(any())).thenAnswer(
        (_) async => const Right(null),
      );

      // Act
      final result = await useCase('id');

      // Assert
      expect(result, const Right<dynamic, void>(null));

      verify(() => repository.markAsRead('id')).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
