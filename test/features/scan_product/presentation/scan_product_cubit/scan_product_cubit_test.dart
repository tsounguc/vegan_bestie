import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_product.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/scan_barcode.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class MockScanProduct extends Mock implements ScanBarcode {}

class MockFetchProduct extends Mock implements FetchProduct {}

void main() {
  late ScanBarcode scanBarcode;
  late FetchProduct fetchProduct;
  late ScanProductCubit cubit;
  setUp(() {
    scanBarcode = MockScanProduct();
    fetchProduct = MockFetchProduct();
    cubit = ScanProductCubit(
      scanBarcode: scanBarcode,
      fetchProduct: fetchProduct,
    );
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
}
