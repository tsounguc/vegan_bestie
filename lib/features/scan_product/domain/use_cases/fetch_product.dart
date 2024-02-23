import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/domain/entities/scanned_product.dart';
import 'package:sheveegan/features/scan_product/domain/repositories_contracts/scanning_repository.dart';

class FetchProduct extends UseCaseWithParams<ScannedProduct, FetchProductParams> {
  FetchProduct(this._repository);

  final ScanProductRepository _repository;

  // @override
  // ResultFuture<ScannedProduct> call(FetchProductParams params) => _repository.fetchProduct(barcode: params.barcode);

  @override
  ResultFuture<ScannedProduct> call(FetchProductParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class FetchProductParams extends Equatable {
  const FetchProductParams({
    required this.barcode,
  });

  const FetchProductParams.empty() : this(barcode: 'empty.barcode');

  final String barcode;

  @override
  List<Object?> get props => [barcode];
}
