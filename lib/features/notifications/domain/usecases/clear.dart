import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/notifications/domain/repositories/notifications_repository.dart';

class Clear extends UseCaseWithParams<void, String> {
  const Clear(this._repository);

  final NotificationRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.clear(params);
}
