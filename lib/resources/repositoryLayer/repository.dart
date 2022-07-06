import 'package:sheveegan/resources/networkLayer/open_food_facts_api_provider.dart';

import '../../model/product_info_model.dart';

class Repository {
  final openFoodFactApiProvider = OpenFoodFactsApiProvider();

  Future<ProductInfoModel> fetchProduct(String barcode){
    return openFoodFactApiProvider.fetchProduct(barcode);
  }
}