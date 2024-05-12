import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class DeleteReport implements UseCaseWithParams<void, FoodProductReport> {
  const DeleteReport(this._repository);

  final FoodProductRepository _repository;
  @override
  ResultFuture<void> call(FoodProductReport params) async => _repository.deleteReport(params);
}
