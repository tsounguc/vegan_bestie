import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/services/vegan_checker.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_product.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/scan_barcode.dart';

part 'scan_product_state.dart';

class ScanProductCubit extends Cubit<ScanProductState> {
  ScanProductCubit({required ScanBarcode scanBarcode, required FetchProduct fetchProduct})
      : _scanBarcode = scanBarcode,
        _fetchProduct = fetchProduct,
        super(const ScanProductInitial());
  final ScanBarcode _scanBarcode;
  final FetchProduct _fetchProduct;

  Future<void> scanBarcode() async {
    emit(const ScanningBarcode());
    final result = await _scanBarcode();
    result.fold(
      (failure) => emit(ScanProductError(message: failure.errorMessage)),
      (success) => emit(BarcodeFound(barcode: success.barcode)),
    );
  }

  Future<void> fetchProduct({required String barcode}) async {
    emit(const FetchingProduct());
    final result = await _fetchProduct(FetchProductParams(barcode: barcode));
    final veganChecker = VeganChecker();
    result.fold(
      (failure) => emit(ScanProductError(message: failure.errorMessage)),
      (product) {
        if (product.productName.isEmpty) {
          emit(const ProductNotFound());
        } else {
          final isVegan = veganChecker.veganCheck(product);
          emit(
            ProductFound(
              product: product,
              nonVeganIngredients: veganChecker.nonVeganIngredientsInProduct,
              isVegan: isVegan,
            ),
          );
        }
      },
    );
  }
}
