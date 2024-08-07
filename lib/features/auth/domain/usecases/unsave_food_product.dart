import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class UnSaveFoodProduct extends UseCaseWithParams<void, String> {
  const UnSaveFoodProduct(this._repository);

  final FoodProductRepository _repository;

  @override
  ResultVoid call(String params) async => _repository.unSaveFoodProduct(barcode: params);
}
