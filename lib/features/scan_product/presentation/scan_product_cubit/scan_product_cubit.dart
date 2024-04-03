import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/resources/strings.dart';
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
      (failure) => emit(ScanProductError(message: failure.message)),
      (success) => emit(BarcodeFound(barcode: success.barcode)),
    );
  }

  Future<void> fetchProduct({required String barcode}) async {
    emit(const FetchingProduct());
    final result = await _fetchProduct(FetchProductParams(barcode: barcode));
    final veganChecker = VeganChecker();
    result.fold(
      (failure) {
        if (failure.message == Strings.productNotFound) {
          emit(const ProductNotFound());
        } else {
          emit(ScanProductError(message: failure.message));
        }
      },
      (product) {
        if (product.productName.isEmpty) {
          emit(const ProductNotFound());
        } else {
          final isVegan = veganChecker.veganCheck(product);
          print('product found');
          var isVegetarian = false;
          if (!isVegan) {
            isVegetarian = veganChecker.vegetarianCheck(product);
            emit(
              ProductFound(
                product: product,
                nonVeganIngredients: isVegetarian
                    ? veganChecker.nonVeganIngredientsInProduct
                    : veganChecker.nonVegetarianIngredientsInProduct,
                isVegan: false,
                isVegetarian: isVegetarian,
              ),
            );
          } else {
            emit(
              ProductFound(
                  product: product,
                  nonVeganIngredients: veganChecker.nonVeganIngredientsInProduct,
                  isVegan: isVegan,
                  isVegetarian: false),
            );
          }
        }
      },
    );
  }
}
