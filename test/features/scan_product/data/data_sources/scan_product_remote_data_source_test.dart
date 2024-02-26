import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/features/scan_product/data/data_sources/barcode_scanner_plugin.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/scan_product/data/data_sources/scan_product_remote_data_source.dart';
import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/scan_product/data/models/food_product_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockScanner extends Mock implements BarcodeScannerService {}

class MockClient extends Mock implements Client {}

void main() {
  late MockScanner scanner;
  late Client client;
  late ScanProductRemoteDataSource remoteDataSource;
  setUp(() {
    scanner = MockScanner();
    client = MockClient();
    remoteDataSource = ScanProductRemoteDataSourceImpl(scanner, client);
    registerFallbackValue(Uri());
  });
  group('scanBarcode', () {
    const testBarcodeString = '123456789012';
    test(
      'given ScanProductRemoteDataSourceImpl '
      'when [ScanProductRemoteDataSourceImpl.scanProduct] is called '
      'and call to plugin successful '
      'then return [BarcodeModel]',
      () async {
        // Arrange
        when(
          () => scanner.scanBarcode(),
        ).thenAnswer((_) async => testBarcodeString);

        // Act
        final result = await remoteDataSource.scanBarcode();

        // Assert
        expect(result, isA<BarcodeModel>());
        verify(() => scanner.scanBarcode()).called(1);
        verifyNoMoreInteractions(scanner);
      },
    );

    test(
        'given ScanProductRemoteDataSourceImpl '
        'when [ScanProductRemoteDataSourceImpl.scanProduct] is called '
        'and call to plugin unsuccessful '
        'then throw [ScanException] ', () async {
      // Arrange
      when(
        () => scanner.scanBarcode(),
      ).thenThrow(const ScanException(message: 'Invalid barcode'));
      // Act
      final methodCall = remoteDataSource.scanBarcode;

      // Assert
      expect(
        () async => methodCall(),
        throwsA(const ScanException(message: 'Invalid barcode')),
      );
      verify(() => scanner.scanBarcode()).called(1);
      verifyNoMoreInteractions(scanner);
    });
  });

  group('fetchProduct - ', () {
    const testBarcode = '123456789012';

    test(
      'given ScanProductRemoteDataSourceImpl, '
      'when [ScanProductRemoteDataSourceImpl.fetchProduct] is called '
      'and status is 200 '
      'then return [FoodProductModel] ',
      () async {
        // Arrange
        final testJson = fixture('food_product.json');
        when(
          () => client.get(
            Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$testBarcode'),
          ),
        ).thenAnswer((_) async => Response(testJson, 200));

        // Act
        final foodProduct = await remoteDataSource.fetchProduct(
          barcode: testBarcode,
        );

        // Assert
        expect(foodProduct, isA<FoodProductModel>());
        expect(foodProduct.productName, isNotEmpty);
        verify(
          () => client.get(
            Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$testBarcode'),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
    test(
      'given ScanProductRemoteDataSourceImpl, '
      'when [ScanProductRemoteDataSourceImpl.fetchProduct] is called '
      'and status is 200 and productName is empty '
      'then return [FoodProductModel] ',
      () async {
        // Arrange
        final testJson = fixture('food_product.json');
        when(
          () => client.get(
            Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$testBarcode'),
          ),
        ).thenAnswer(
          (_) async => Response(
            '''
        {
            'code': '0025293600232',
            'productName': '',
            'ingredients': [],
            'ingredients_text': '',
            'labels': '',
            'image_front_url': '',
            'proteins': 0.0,
            'proteins_100g': 0.0,
            'proteins_unit': '',
            'proteins_value': 0.0,
            'carbohydrates': 0.0,
            'carbohydrates_100g': 0.0,
            'carbohydrates_unit': '',
            'carbohydrates_value': 0.0,
            'fat': 0.0,
            'fat_100g': 0.0,
            'fat_unit': '',
            'fat_value': 0.0,
            'id': '',
            'keywords': [],
            'imageFrontSmallUrl': '',
            'imageFrontThumbUrl': '',
            'imageIngredientsSmallUrl': '',
            'imageIngredientsThumbUrl': '',
            'imageIngredientsUrl': '',
            'imageNutritionSmallUrl': '',
            'imageNutritionThumbUrl': '',
            'imageNutritionUrl': '',
            'imageSmallUrl': '',
            'imageThumbUrl': '',
            'imageUrl': '',
            'quantity': '',
            'servingQuantity': '',
            'servingSize': '',
          }''',
            505,
          ),
        );

        // Act
        // final foodProduct = await remoteDataSource.fetchProduct(
        //   barcode: testBarcode,
        // );
        final methodCall = remoteDataSource.fetchProduct;

        // Assert
        expect(
          () async => methodCall(barcode: testBarcode),
          throwsA(
            const FetchProductException(
              message: 'Product not Found',
              statusCode: 505,
            ),
          ),
        );
        expect(() => methodCall(barcode: testBarcode), isEmpty);
        verify(
          () => client.get(
            Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$testBarcode'),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'given ScanProductRemoteDataSourceImpl, '
      'when [ScanProductRemoteDataSourceImpl.fetchProduct] is called '
      'and status is not 200 '
      'then throw a [FetchProductException] ',
      () async {
        // Arrange
        when(
          () => client.get(
            Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$testBarcode'),
          ),
        ).thenAnswer((_) async => Response('Server Down', 500));

        // Act
        final methodCall = remoteDataSource.fetchProduct;

        // Assert
        expect(
          () async => methodCall(barcode: testBarcode),
          throwsA(
            const FetchProductException(
              message: 'Server Down',
              statusCode: 500,
            ),
          ),
        );
        verify(
          () => client.get(
            Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$testBarcode'),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
