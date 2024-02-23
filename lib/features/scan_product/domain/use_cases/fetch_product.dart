import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/domain/repositories/scan_product_repository.dart';

class FetchProduct extends UseCaseWithParams<FoodProduct, FetchProductParams> {
  FetchProduct(this._repository);

  final ScanProductRepository _repository;

  @override
  ResultFuture<FoodProduct> call(FetchProductParams params) async =>
      _repository.fetchProduct(barcode: params.barcode);
}

class FetchProductParams extends Equatable {
  const FetchProductParams({required this.barcode});

  const FetchProductParams.empty() : this(barcode: 'empty.barcode');

  final String barcode;

  @override
  List<Object?> get props => [barcode];
}
