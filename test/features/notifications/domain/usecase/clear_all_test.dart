import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:sheveegan/features/notifications/domain/usecases/clear_all.dart';

import 'notification_repository.mock.dart';

void main() {
  late NotificationRepository repository;
  late ClearAll useCase;

  setUp(() {
    repository = MockNotificationRepository();
    useCase = ClearAll(repository);
  });

  test(
    'given ClearAll use case '
    'when instantiated '
    'then [NotificationRepository.clearAll] should be called',
    () async {
      // Arrange
      when(() => repository.clearAll()).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right<dynamic, void>(null));

      verify(() => repository.clearAll()).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
