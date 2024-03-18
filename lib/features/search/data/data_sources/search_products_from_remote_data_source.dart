// import '../../../../core/failures_successes/exceptions.dart';
// import '../../../../core/services/service_locator.main.dart';
// import '../models/search_product_model.dart';
//
// abstract class SearchProductsFromRemoteDataSourceContract {
//   Future<List<SearchProductModel>> searchProduct(String query);
// }
//
// class SearchProductsFromRemoteDataSourceImpl implements SearchProductsFromRemoteDataSourceContract {
//   final FoodFactsApiServiceContract foodFactsApiServiceContract = serviceLocator<FoodFactsApiServiceContract>();
//
//   @override
//   Future<List<SearchProductModel>> searchProduct(String query) async {
//     try {
//       //Receive results from api contract
//       Map<String, dynamic> data = await foodFactsApiServiceContract.searchProduct(query: query);
//
//       //Retrieve products list from api received results
//       List searchProductsData = data['products'];
//
//       // Initialize a list of product json/map Objects
//       List<Map<String, dynamic>> productJsonObjectsList = [];
//
//       // Populate list of product json/map objects with retrieved list from api received results
//       for (int index = 0; index < searchProductsData.length; index++) {
//         Map<String, dynamic> searchProductJsonObject = searchProductsData[index] as Map<String, dynamic>;
//         productJsonObjectsList.add(searchProductJsonObject);
//       }
//
//       // Initialize a list of product models
//       List<SearchProductModel> searchProductModelsList = [];
//
//       // Populate list of restaurant models
//       for (int index = 0; index < productJsonObjectsList.length; index++) {
//         SearchProductModel searchProductModel = SearchProductModel.fromJson(productJsonObjectsList[index]);
//         searchProductModelsList.add(searchProductModel);
//       }
//       return searchProductModelsList;
//     } catch (e) {
//       throw const SearchProductException(message: "Failed to get list of restaurants");
//     }
//   }
// }
