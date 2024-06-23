import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';

class MarkAsRead extends UseCaseWithParams<void, String> {
  const MarkAsRead(this._repository);

  final NotificationRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.markAsRead(params);
}
