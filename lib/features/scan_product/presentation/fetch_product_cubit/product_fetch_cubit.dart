import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/services/vegan_checker.dart';
import 'package:sheveegan/features/scan_product/domain/entities/scanned_product.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_product.dart';

part 'product_fetch_state.dart';

class ProductFetchCubit extends Cubit<ProductFetchState> {
  final FetchProduct _fetchProductUseCase = serviceLocator<FetchProduct>();

  ProductFetchCubit() : super(ProductFetchInitial());

  Future<void> fetchProduct(String barcode) async {
    emit(ProductLoadingState());
    final Either<FetchProductFailure, ScannedProduct> fetchProductResult =
        await _fetchProductUseCase.fetchProduct(barcode);
    VeganChecker veganChecker = VeganChecker();

    fetchProductResult.fold(
      (fetchFailure) => emit(ProductFetchErrorState(error: fetchFailure.message)),
      (productInfo) {
        if (productInfo == null || productInfo.productName == null || productInfo.productName!.isEmpty) {
          emit(ProductNotFoundState());
        } else {
          print("Product Name: ${productInfo.productName}");
          bool isVegan = veganChecker.veganCheck(productInfo);
          emit(
            ProductFoundState(
              product: productInfo,
              nonVeganIngredientsInProduct: veganChecker.nonVeganIngredientsInProduct,
              isVegan: isVegan,
            ),
          );
        }
      },
    );
  }
}
