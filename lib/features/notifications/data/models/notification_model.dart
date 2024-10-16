import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheveegan/core/enums/notification_enum.dart';
import 'package:sheveegan/core/extensions/enum_extensions.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.category,
    required super.sentAt,
    super.seen = false,
  });

  NotificationModel.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          body: '_empty.body',
          category: NotificationCategory.NONE,
          seen: false,
          sentAt: DateTime.now(),
        );

  NotificationModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          title: map['title'] as String,
          body: map['body'] as String,
          category: (map['category'] as String).toNotificationCategory,
          seen: map['seen'] as bool,
          sentAt: (map['sentAt'] as Timestamp).toDate(),
        );

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationCategory? category,
    bool? seen,
    DateTime? sentAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      category: category ?? this.category,
      seen: seen ?? this.seen,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  DataMap toMap() => {
        'id': id,
        'title': title,
        'body': body,
        'category': category.value,
        'seen': seen,
        'sentAt': FieldValue.serverTimestamp(),
      };
}
