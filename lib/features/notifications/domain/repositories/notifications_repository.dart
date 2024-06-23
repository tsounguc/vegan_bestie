import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';

abstract class NotificationRepository {
  const NotificationRepository();

  ResultVoid markAsRead(String notificationId);

  ResultVoid clearAll();

  ResultVoid clear(String notificationId);

  ResultVoid sendNotification(Notification notification);

  ResultStream<List<Notification>> getNotifications();
}
