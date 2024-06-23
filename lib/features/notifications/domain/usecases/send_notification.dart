import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';

class SendNotification extends UseCaseWithParams<void, Notification> {
  const SendNotification(this._repository);

  final NotificationRepository _repository;

  @override
  ResultFuture<void> call(Notification params) => _repository.sendNotification(params);
}
