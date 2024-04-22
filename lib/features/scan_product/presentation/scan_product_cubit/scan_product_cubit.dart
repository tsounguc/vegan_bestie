import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/vegan_checker.dart';
import 'package:sheveegan/features/auth/domain/usecases/remove_food_product.dart';
import 'package:sheveegan/features/auth/domain/usecases/save_food_product.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_product.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_saved_products_list.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/scan_barcode.dart';

part 'scan_product_state.dart';

class ScanProductCubit extends Cubit<ScanProductState> {
  ScanProductCubit(
      {required ScanBarcode scanBarcode,
      required FetchProduct fetchProduct,
      required SaveFoodProduct saveFoodProduct,
      required RemoveFoodProduct removeFoodProduct,
      required FetchSavedProductsList fetchSavedProductsList})
      : _scanBarcode = scanBarcode,
        _fetchProduct = fetchProduct,
        _saveFoodProduct = saveFoodProduct,
        _removeFoodProduct = removeFoodProduct,
        _fetchSavedProductsList = fetchSavedProductsList,
        super(const ScanProductInitial());
  final ScanBarcode _scanBarcode;
  final FetchProduct _fetchProduct;
  final SaveFoodProduct _saveFoodProduct;
  final RemoveFoodProduct _removeFoodProduct;
  final FetchSavedProductsList _fetchSavedProductsList;
  final veganChecker = VeganChecker();

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
          emit(
            ProductFound(
              product: product,
            ),
          );
        }
      },
    );
  }

  Future<void> saveFoodProductHandler({required FoodProduct product}) async {
    emit(const SavingFoodProduct());

    final result = await _saveFoodProduct(product.code);

    result.fold((failure) => emit(ScanProductError(message: failure.message)), (success) {
      if (product.productName.isEmpty) {
        emit(const ProductNotFound());
      } else {
        emit(
          ProductFound(
            product: product,
          ),
        );
      }
    });
  }

  Future<void> removeFoodProductHandler({required FoodProduct product}) async {
    emit(const RemovingFoodProduct());

    final result = await _removeFoodProduct(product.code);

    result.fold(
      (failure) => emit(ScanProductError(message: failure.message)),
      (success) {
        if (product.productName.isEmpty) {
          emit(const ProductNotFound());
        } else {
          emit(ProductFound(product: product));
        }
      },
    );
  }

  Future<void> fetchProductsList(List<String> savedBarcodesList) async {
    emit(const FetchingProductsList());
    final result = await _fetchSavedProductsList(savedBarcodesList);
    result.fold(
      (failure) => emit(
        ScanProductError(message: failure.message),
      ),
      (savedProductsList) {
        emit(SavedProductsListFetched(savedProductsList: savedProductsList));
        ;
      },
    );
  }
}
