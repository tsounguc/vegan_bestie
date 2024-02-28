// import '../../domain/entities/search_product_entity.dart';
//
// class SearchProductMapper {
//   SearchProductEntity mapToEntity(SearchProductModel searchProductModel) {
//     List<SearchIngredientEntity> ingredients = [];
//     for (int index = 0; index < searchProductModel.ingredients!.length; index++) {
//       SearchIngredientEntity ingredient = SearchIngredientEntity(
//         id: searchProductModel.ingredients?[index].id,
//         percentEstimate: searchProductModel.ingredients?[index].percentEstimate,
//         percentMax: searchProductModel.ingredients?[index].percentMax,
//         percentMin: searchProductModel.ingredients?[index].percentMin,
//         text: searchProductModel.ingredients?[index].text,
//         vegan: searchProductModel.ingredients?[index].vegan,
//         vegetarian: searchProductModel.ingredients?[index].vegetarian,
//       );
//       ingredients.add(ingredient);
//     }
//     return SearchProductEntity(
//       code: searchProductModel.code,
//       productName: searchProductModel.productName,
//       ingredients: ingredients,
//       ingredientsText: searchProductModel.ingredientsText,
//       labels: searchProductModel.labels,
//       imageFrontUrl: searchProductModel.imageFrontUrl,
//       proteins: searchProductModel.nutriments?.proteins,
//       proteins100G: searchProductModel.nutriments?.proteins100G,
//       proteinsUnit: searchProductModel.nutriments?.proteinsUnit,
//       proteinsValue: searchProductModel.nutriments?.proteinsValue,
//       carbohydrates: searchProductModel.nutriments?.carbohydrates,
//       carbohydrates100G: searchProductModel.nutriments?.carbohydrates100G,
//       carbohydratesUnit: searchProductModel.nutriments?.carbohydratesUnit,
//       carbohydratesValue: searchProductModel.nutriments?.carbohydratesValue,
//       fat: searchProductModel.nutriments?.fat,
//       fat100G: searchProductModel.nutriments?.fat100G,
//       fatUnit: searchProductModel.nutriments?.fatUnit,
//       fatValue: searchProductModel.nutriments?.fatValue,
//     );
//   }
// }
