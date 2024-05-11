import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/auth/domain/usecases/remove_food_product.dart';
import 'package:sheveegan/features/auth/domain/usecases/save_food_product.dart';
import 'package:sheveegan/features/food_product/domain/entities/barcode.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/add_food_product.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/fetch_product.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/fetch_saved_products_list.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/read_ingredients_from_image.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/report_issue.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/scan_barcode.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/update_food_product.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';

class MockScanProduct extends Mock implements ScanBarcode {}

class MockFetchProduct extends Mock implements FetchProduct {}

class MockSaveFoodProduct extends Mock implements SaveFoodProduct {}

class MockRemoveFoodProduct extends Mock implements RemoveFoodProduct {}

class MockFetchSavedProductsList extends Mock implements FetchSavedProductsList {}

class MockReadIngredientsFromImage extends Mock implements ReadIngredientsFromImage {}

class MockUpdateFoodProduct extends Mock implements UpdateFoodProduct {}

class MockAddFoodProduct extends Mock implements AddFoodProduct {}

class MockReportIssue extends Mock implements ReportIssue {}

void main() {
  late ScanBarcode scanBarcode;
  late FetchProduct fetchProduct;
  late SaveFoodProduct saveFoodProduct;
  late RemoveFoodProduct removeFoodProduct;
  late FetchSavedProductsList fetchSavedProductsList;
  late FoodProductCubit cubit;
  late FetchProductParams testFetchProductParams;
  late ReadIngredientsFromImage readIngredientsFromImage;
  late UpdateFoodProduct updateFoodProduct;
  late AddFoodProduct addFoodProduct;
  late ReportIssue reportIssue;
  setUp(() {
    scanBarcode = MockScanProduct();
    fetchProduct = MockFetchProduct();
    saveFoodProduct = MockSaveFoodProduct();
    removeFoodProduct = MockRemoveFoodProduct();
    fetchSavedProductsList = MockFetchSavedProductsList();
    readIngredientsFromImage = MockReadIngredientsFromImage();
    updateFoodProduct = MockUpdateFoodProduct();
    addFoodProduct = MockAddFoodProduct();
    reportIssue = MockReportIssue();
    cubit = FoodProductCubit(
      scanBarcode: scanBarcode,
      fetchProduct: fetchProduct,
      saveFoodProduct: saveFoodProduct,
      removeFoodProduct: removeFoodProduct,
      fetchSavedProductsList: fetchSavedProductsList,
      readIngredientsFromImage: readIngredientsFromImage,
      updateFoodProduct: updateFoodProduct,
      addFoodProduct: addFoodProduct,
      reportIssue: reportIssue,
    );
    testFetchProductParams = const FetchProductParams.empty();
    registerFallbackValue(testFetchProductParams);
  });

  tearDown(() => cubit.close());

  test(
      'given ScanProductCubit '
      'when cubit is instantiated '
      'then initial should be [ScanProductInitial]', () async {
    // Arrange
    // Act
    // Assert
    expect(cubit.state, const ScanProductInitial());
  });

  group('scanBarcode - ', () {
    const testBarcode = Barcode.empty();
    final testScanFailure = ScanFailure(message: 'message', statusCode: 400);
    blocTest<FoodProductCubit, FoodProductState>(
      'given ScanProductCubit '
      'when [ScanProductCubit.scanBarcode] call completed successfully '
      'then emit [ScanningBarcode, BarcodeFound] ',
      build: () {
        when(() => scanBarcode()).thenAnswer(
          (_) async => const Right(testBarcode),
        );
        return cubit;
      },
      act: (cubit) => cubit.scanBarcode(),
      expect: () => [
        const ScanningBarcode(),
        BarcodeFound(barcode: testBarcode.barcode),
      ],
      verify: (cubit) {
        verify(() => scanBarcode()).called(1);
        verifyNoMoreInteractions(scanBarcode);
      },
    );
    blocTest<FoodProductCubit, FoodProductState>(
      'given ScanProductCubit '
      'when [ScanProductCubit.scanBarcode] call unsuccessful '
      'then emit [ScanningBarcode, ScanProductError] ',
      build: () {
        when(() => scanBarcode()).thenAnswer(
          (_) async => Left(testScanFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.scanBarcode(),
      expect: () => [
        const ScanningBarcode(),
        FoodProductError(message: testScanFailure.message),
      ],
      verify: (cubit) {
        verify(() => scanBarcode()).called(1);
        verifyNoMoreInteractions(scanBarcode);
      },
    );
  });

  group('fetchProduct - ', () {
    final testFoodProduct = FoodProduct.empty();
    final testScanFailure = ScanFailure(message: 'message', statusCode: 400);

    blocTest<FoodProductCubit, FoodProductState>(
      'given ScanProductCubit '
      'when [ScanProductCubit.scanBarcode] call completed successfully '
      'then emit [FetchingProduct, ProductFound] ',
      build: () {
        when(() => fetchProduct(any())).thenAnswer(
          (_) async => Right(testFoodProduct),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchProduct(
        barcode: testFetchProductParams.barcode,
      ),
      expect: () => [
        const FetchingProduct(),
        ProductFound(
          product: testFoodProduct,
        ),
      ],
      verify: (cubit) {
        verify(() => fetchProduct(testFetchProductParams)).called(1);
        verifyNoMoreInteractions(fetchProduct);
      },
    );
    blocTest<FoodProductCubit, FoodProductState>(
      'given ScanProductCubit '
      'when [ScanProductCubit.fetchProduct] call unsuccessful '
      'then emit [FetchingProduct, ScanProductError] ',
      build: () {
        when(() => fetchProduct(any())).thenAnswer(
          (_) async => Left(testScanFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchProduct(
        barcode: testFetchProductParams.barcode,
      ),
      expect: () => [
        const FetchingProduct(),
        FoodProductError(message: testScanFailure.message),
      ],
      verify: (cubit) async {
        verify(() => fetchProduct(testFetchProductParams)).called(1);
        verifyNoMoreInteractions(fetchProduct);
      },
    );
  });
}
