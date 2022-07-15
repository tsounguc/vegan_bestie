import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/data/models/product_info_model.dart';
import 'package:sheveegan/data/repositoryLayer/repository.dart';

part 'product_fetch_state.dart';

class ProductFetchCubit extends Cubit<ProductFetchState> {
  final Repository repository;

  // final BarcodeScannerCubit barcodeScannerCubit;

  // late StreamSubscription barcodeScannerSubscription;

  ProductFetchCubit({
    required this.repository,
    // required this.barcodeScannerCubit,
  }) : super(ProductFetchInitial());

  // {
  //   print("before listener: Listening");
  //   barcodeScannerSubscription = barcodeScannerCubit.stream.listen((barcodeScannerState){
  //     if (barcodeScannerState is BarcodeFoundState) {
  //       print("listener: Listening");
  //       fetchProduct(barcodeScannerState.barcode);
  //     }
  //   });
  // }

  Future<void> fetchProduct(String barcode) async {
    try {
      emit(ProductLoadingState());
      final productInfo = await repository.fetchProduct(barcode);
      if (productInfo!.status == 0) {
        emit(ProductNotFoundState(message: productInfo.statusVerbose!));
      } else if (productInfo.status == 1) {
        print("Product Name: ${productInfo.product?.productName}");
        emit(ProductFoundState(product: productInfo));
      }
    } on Error catch (e) {
      emit(ProductFetchErrorState(error: "$e \n${e.stackTrace} "));
      throw Exception(e);
    } catch (e) {
      emit(ProductFetchErrorState(error: "$e"));
      debugPrint('Error: $e');
    }
  }
}
