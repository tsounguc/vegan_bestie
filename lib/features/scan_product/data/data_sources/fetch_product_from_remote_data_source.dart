import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/core/services/food_facts_services/food_facts_api_service.dart';
import 'package:sheveegan/features/scan_product/data/models/product_info_model.dart';

abstract class FetchProductFromRemoteDataSourceContract {
  Future<ScanProductModel> fetchProduct(String barcode);
}

class FetchProductFromRemoteDataSourceImpl implements FetchProductFromRemoteDataSourceContract {
  final FoodFactsApiServiceContract foodFactsApiServiceContract = serviceLocator<FoodFactsApiServiceContract>();
  @override
  Future<ScanProductModel> fetchProduct(String barcode) async {
    try {
      Map<String, dynamic> data = await foodFactsApiServiceContract.getProductData(barcode: barcode);
      ScanProductModel productInfo = ScanProductModel.fromJson(data['product']);
      return productInfo;
    } catch (e) {
      throw const FetchProductException(message: "Product Not Found");
    }
  }
}
