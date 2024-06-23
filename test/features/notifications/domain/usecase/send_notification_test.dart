import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:sheveegan/features/notifications/domain/usecases/send_notification.dart';

import 'notification_repository.mock.dart';

void main() {
  late NotificationRepository repository;
  late SendNotification useCase;
  final testNotification = Notification.empty();
  setUp(() {
    repository = MockNotificationRepository();
    useCase = SendNotification(repository);
    registerFallbackValue(testNotification);
  });

  test(
    'given SendNotification use case '
    'when instantiated '
    'then [NotificationRepository.sendNotification] should be called',
    () async {
      // Arrange
      when(() => repository.sendNotification(any())).thenAnswer(
        (_) async => const Right(null),
      );

      // Act
      final result = await useCase(testNotification);

      // Assert
      expect(result, const Right<dynamic, void>(null));

      verify(() => repository.sendNotification(testNotification)).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
