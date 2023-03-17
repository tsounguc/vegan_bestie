import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/core/services/food_facts_services/food_facts_api_service.dart';
import 'package:sheveegan/features/scan_product/data/models/product_info_model.dart';

abstract class FetchProductFromRemoteDataSourceContract {
  Future<ProductInfoModel> fetchProduct(String barcode);
}

class FetchProductFromRemoteDataSourceImpl implements FetchProductFromRemoteDataSourceContract {
  final FoodFactsApiServiceContract factsApiServiceContract = serviceLocator<FoodFactsApiServiceContract>();
  @override
  Future<ProductInfoModel> fetchProduct(String barcode) async {
    try {
      Map<String, dynamic> data = await factsApiServiceContract.getProductData(barcode: barcode);
      ProductInfoModel productInfo = ProductInfoModel.fromJson(data['product']);
      return productInfo;
    } catch (e) {
      throw const FetchProductException(message: "Product Not Found");
    }
  }
}
