import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/vegan_checker.dart';
import '../../domain/entities/scan_product_entity.dart';
import '../../domain/usecases/fetch_product_usecase.dart';

part 'product_fetch_state.dart';

class ProductFetchCubit extends Cubit<ProductFetchState> {
  final FetchProductUseCase _fetchProductUseCase = serviceLocator<FetchProductUseCase>();

  ProductFetchCubit() : super(ProductFetchInitial());

  Future<void> fetchProduct(String barcode) async {
    emit(ProductLoadingState());
    final Either<FetchProductFailure, ScanProductEntity> fetchProductResult =
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
