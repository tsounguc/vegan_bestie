import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class ReportIssue implements UseCaseWithParams<void, FoodProductReport> {
  const ReportIssue(this._repository);

  final FoodProductRepository _repository;

  @override
  ResultVoid call(FoodProductReport params) => _repository.reportIssue(params);
}
