import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';

class GetNotifications extends StreamUseCase<List<Notification>> {
  const GetNotifications(this._repository);

  final NotificationRepository _repository;

  @override
  ResultStream<List<Notification>> call() => _repository.getNotifications();
}
