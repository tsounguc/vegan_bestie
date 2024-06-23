import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:sheveegan/features/notifications/domain/usecases/get_notifications.dart';

import 'notification_repository.mock.dart';

void main() {
  late NotificationRepository repository;
  late GetNotifications useCase;

  setUp(() {
    repository = MockNotificationRepository();
    useCase = GetNotifications(repository);
  });

  test(
    'given GetNotifications use case '
    'when instantiated '
    'then call [NotificationRepository.getNotifications] '
    'and return a [Stream<List<Notification>>] ',
    () async {
      // Arrange
      when(() => repository.getNotifications()).thenAnswer(
        (_) => Stream.value(const Right([])),
      );

      // Act
      final result = useCase();

      // Assert
      expect(result, emits(const Right<dynamic, List<Notification>>([])));

      verify(() => repository.getNotifications()).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
