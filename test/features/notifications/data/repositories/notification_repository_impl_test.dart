import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:sheveegan/features/notifications/data/models/notification_model.dart';
import 'package:sheveegan/features/notifications/data/repositories/notification_repo_impl.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';

class MockNotificationRemoteDataSource extends Mock implements NotificationRemoteDatasource {}

void main() {
  late NotificationRemoteDatasource remoteDataSrc;
  late NotificationRepositoryImpl repo;

  setUp(() {
    remoteDataSrc = MockNotificationRemoteDataSource();
    repo = NotificationRepositoryImpl(remoteDataSrc);
  });

  final tNotification = NotificationModel.empty();
  const tException = ServerException(message: 'message', statusCode: 'statusCode');

  group('clear', () {
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        when(() => remoteDataSrc.clear(any())).thenAnswer(
          (_) async => const Right<dynamic, void>(null),
        );
        final result = await repo.clear('id');
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => remoteDataSrc.clear('id')).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.clear(any())).thenThrow(tException);
        final result = await repo.clear('id');

        expect(
          result,
          equals(
            Left<Failure, dynamic>(ServerFailure.fromException(tException)),
          ),
        );
        verify(() => remoteDataSrc.clear('id')).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('clearAll', () {
    test(
      'should complete successfully when call to remote source is '
      'successful',
      () async {
        when(() => remoteDataSrc.clearAll()).thenAnswer(
          (_) async => const Right<dynamic, void>(null),
        );
        final result = await repo.clearAll();
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => remoteDataSrc.clearAll()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.clearAll()).thenThrow(tException);
        final result = await repo.clearAll();

        expect(
          result,
          equals(
            Left<Failure, dynamic>(ServerFailure.fromException(tException)),
          ),
        );
        verify(() => remoteDataSrc.clearAll()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('markAsRead', () {
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        when(() => remoteDataSrc.markAsRead(any())).thenAnswer(
          (_) async => const Right<dynamic, void>(null),
        );

        final result = await repo.markAsRead('id');

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => remoteDataSrc.markAsRead('id')).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.markAsRead(any())).thenThrow(tException);

        final result = await repo.markAsRead('id');

        expect(
          result,
          equals(
            Left<Failure, dynamic>(ServerFailure.fromException(tException)),
          ),
        );

        verify(() => remoteDataSrc.markAsRead('id')).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('sendNotification', () {
    setUp(() => registerFallbackValue(tNotification));
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        when(() => remoteDataSrc.sendNotification(any()))
            .thenAnswer((_) async => const Right<dynamic, void>(null));

        final result = await repo.sendNotification(tNotification);

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => remoteDataSrc.sendNotification(tNotification)).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.sendNotification(any())).thenThrow(tException);

        final result = await repo.sendNotification(tNotification);

        expect(
          result,
          equals(
            Left<Failure, dynamic>(ServerFailure.fromException(tException)),
          ),
        );

        verify(() => remoteDataSrc.sendNotification(tNotification)).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });

  group('getNotifications', () {
    test(
      'should emit a [List<Notification>] when call to remote source is '
      'successful',
      () {
        // Arrange
        final notifications = [NotificationModel.empty()];
        when(() => remoteDataSrc.getNotifications()).thenAnswer(
          (_) => Stream.value(notifications),
        );
        // Act
        final result = repo.getNotifications();

        // Assert
        expect(
          result,
          emits(Right<dynamic, List<Notification>>(notifications)),
        );

        verify(() => remoteDataSrc.getNotifications()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should emit a [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.getNotifications()).thenAnswer(
          (_) => Stream.error(tException),
        );

        final result = repo.getNotifications();

        expect(
          result,
          emits(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );

        verify(() => remoteDataSrc.getNotifications()).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });
}
