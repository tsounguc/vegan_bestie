import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sheveegan/core/enums/update_food_product.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/data/data_sources/food_product_remote_data_source.dart';
import 'package:sheveegan/features/food_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';
import 'package:sheveegan/features/food_product/domain/repositories/food_product_repository.dart';

class FoodProductRepositoryImpl implements FoodProductRepository {
  const FoodProductRepositoryImpl(this._remoteDataSource);

  final FoodProductRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<FoodProduct> fetchProduct({required String barcode}) async {
    try {
      final result = await _remoteDataSource.fetchProduct(barcode: barcode);
      return Right(result);
    } on FetchProductException catch (e) {
      return Left(FetchProductFailure.fromException(e));
    }
  }

  @override
  ResultVoid addFoodProduct({required FoodProduct foodProduct, required File productImage}) async {
    try {
      final result = await _remoteDataSource.addFoodProduct(foodProduct: foodProduct, productImage: productImage);
      return Right(result);
    } on AddFoodProductException catch (e) {
      return Left(AddFoodProductFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateFoodProduct({
    required UpdateFoodAction action,
    required dynamic foodData,
    required FoodProduct foodProduct,
  }) async {
    try {
      final result = await _remoteDataSource.updateFoodProduct(
        action: action,
        foodData: foodData,
        foodProduct: foodProduct,
      );
      return Right(result);
    } on UpdateFoodProductException catch (e) {
      return Left(UpdateFoodProductFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Barcode> scanBarcode() async {
    try {
      final result = await _remoteDataSource.scanBarcode();
      return Right(result);
    } on ScanException catch (e) {
      return Left(ScanFailure.fromException(e));
    }
  }

  @override
  ResultVoid unSaveFoodProduct({required String barcode}) async {
    try {
      final result = await _remoteDataSource.unSaveFoodProduct(
        barcode: barcode,
      );
      return Right(result);
    } on SaveFoodProductException catch (e) {
      return Left(SaveFoodProductFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveFoodProduct({required String barcode}) async {
    try {
      final result = await _remoteDataSource.saveFoodProduct(
        barcode: barcode,
      );
      return Right(result);
    } on SaveFoodProductException catch (e) {
      return Left(SaveFoodProductFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<FoodProduct>> fetchSavedProductsList({required List<String> productsList}) async {
    try {
      final result = await _remoteDataSource.fetchSavedProductsList(barcodesList: productsList);
      return Right(result);
    } on FetchProductException catch (e) {
      return Left(FetchProductFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> readIngredientsFromImage({required File image}) async {
    try {
      final result = await _remoteDataSource.readIngredientsFromImage(image: image);
      return Right(result);
    } on ReadIngredientsFromImageException catch (e) {
      return Left(ReadIngredientsFromImageFailure.fromException(e));
    }
  }

  @override
  ResultVoid reportIssue(FoodProductReport report) async {
    try {
      final result = await _remoteDataSource.reportIssue(report);
      return Right(result);
    } on ReportIssueException catch (e) {
      return Left(ReportIssueFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<FoodProductReport>> fetchFoodProductReports() async {
    try {
      final result = await _remoteDataSource.fetchFoodProductReports();
      return Right(result);
    } on ReportIssueException catch (e) {
      return Left(ReportIssueFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteReport(FoodProductReport report) async {
    try {
      final result = await _remoteDataSource.deleteReport(report);
      return Right(result);
    } on DeleteReportException catch (e) {
      return Left(DeleteReportFailure.fromException(e));
    }
  }
}
