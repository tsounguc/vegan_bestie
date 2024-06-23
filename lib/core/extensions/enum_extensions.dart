import 'package:sheveegan/core/enums/notification_enum.dart';

extension NotificationExtension on String {
  NotificationCategory get toNotificationCategory {
    switch (this) {
      case 'restaurant':
        return NotificationCategory.RESTAURANT;
      case 'food':
        return NotificationCategory.FOOD;
      case 'general':
        return NotificationCategory.GENERAL;
      default:
        return NotificationCategory.NONE;
    }
  }
}
