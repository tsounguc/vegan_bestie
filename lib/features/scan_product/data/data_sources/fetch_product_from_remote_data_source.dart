import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/services/food_facts_services/food_facts_api_service.dart';
import 'package:sheveegan/features/scan_product/data/models/food_product_model.dart';

import '../../../../core/constants/strings.dart';

abstract class FetchProductFromRemoteDataSourceContract {
  Future<FoodProductModel> fetchProduct(String barcode);
}

class FetchProductFromRemoteDataSourceImpl implements FetchProductFromRemoteDataSourceContract {
  final FoodFactsApiServiceContract foodFactsApiServiceContract = serviceLocator<FoodFactsApiServiceContract>();

  @override
  Future<FoodProductModel> fetchProduct(String barcode) async {
    try {
      Map<String, dynamic> data = await foodFactsApiServiceContract.getProductData(barcode: barcode);
      FoodProductModel productInfo = FoodProductModel.fromJson(data['product']);
      return productInfo;
    } catch (e) {
      throw FetchProductException(message: Strings.productNotFound);
    }
  }
}
