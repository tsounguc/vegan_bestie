import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:sheveegan/features/notifications/data/models/notification_model.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._remoteDataSource);

  final NotificationRemoteDatasource _remoteDataSource;

  @override
  ResultFuture<void> clear(String notificationId) async {
    try {
      await _remoteDataSource.clear(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> clearAll() async {
    try {
      await _remoteDataSource.clearAll();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultStream<List<Notification>> getNotifications() {
    return _remoteDataSource.getNotifications().transform(
          StreamTransformer<List<NotificationModel>, Either<Failure, List<Notification>>>.fromHandlers(
            handleData: (notifications, sink) {
              sink.add(Right(notifications));
            },
            handleError: (error, stackTrace, sink) {
              debugPrint(stackTrace.toString());
              if (error is ServerException) {
                sink.add(Left(ServerFailure.fromException(error)));
              } else {
                sink.add(
                  Left(
                    ServerFailure(message: error.toString(), statusCode: 505),
                  ),
                );
              }
            },
          ),
        );
  }

  @override
  ResultFuture<void> markAsRead(String notificationId) async {
    try {
      await _remoteDataSource.markAsRead(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> sendNotification(Notification notification) async {
    try {
      await _remoteDataSource.sendNotification(notification);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
