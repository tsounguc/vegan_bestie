import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/barcode_scanner_plugin.dart';
import 'package:sheveegan/features/scan_product/data/data_sources/scan_product_remote_data_source.dart';
import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';

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
}
