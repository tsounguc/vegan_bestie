import '../../domain/entities/scanned_product.dart';
import '../models/product_info_model.dart';

class ScanProductMapper {
  ScannedProduct mapToEntity(ScanProductModel scanProductModel) {
    List<IngredientEntity> ingredients = [];
    for (int index = 0; index < scanProductModel.ingredients!.length; index++) {
      IngredientEntity ingredient = IngredientEntity(
        id: scanProductModel.ingredients?[index].id,
        percentEstimate: scanProductModel.ingredients?[index].percentEstimate,
        percentMax: scanProductModel.ingredients?[index].percentMax,
        percentMin: scanProductModel.ingredients?[index].percentMin,
        text: scanProductModel.ingredients?[index].text,
        vegan: scanProductModel.ingredients?[index].vegan,
        vegetarian: scanProductModel.ingredients?[index].vegetarian,
      );
      ingredients.add(ingredient);
    }
    return ScannedProduct(
      code: scanProductModel.code,
      productName: scanProductModel.productName,
      ingredients: ingredients,
      ingredientsText: scanProductModel.ingredientsText,
      labels: scanProductModel.labels,
      imageFrontUrl: scanProductModel.imageFrontUrl,
      proteins: scanProductModel.nutriments?.proteins,
      proteins100G: scanProductModel.nutriments?.proteins100G,
      proteinsUnit: scanProductModel.nutriments?.proteinsUnit,
      proteinsValue: scanProductModel.nutriments?.proteinsValue,
      carbohydrates: scanProductModel.nutriments?.carbohydrates,
      carbohydrates100G: scanProductModel.nutriments?.carbohydrates100G,
      carbohydratesUnit: scanProductModel.nutriments?.carbohydratesUnit,
      carbohydratesValue: scanProductModel.nutriments?.carbohydratesValue,
      fat: scanProductModel.nutriments?.fat,
      fat100G: scanProductModel.nutriments?.fat100G,
      fatUnit: scanProductModel.nutriments?.fatUnit,
      fatValue: scanProductModel.nutriments?.fatValue,
    );
  }
}
