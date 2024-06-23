import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';

class ClearAll extends UseCase<void> {
  const ClearAll(this._repository);

  final NotificationRepository _repository;

  @override
  ResultFuture<void> call() => _repository.clearAll();
}
