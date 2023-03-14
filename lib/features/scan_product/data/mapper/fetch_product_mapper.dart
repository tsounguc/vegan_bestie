import 'package:sheveegan/features/scan_product/data/models/product_info_model.dart';
import 'package:sheveegan/features/scan_product/domain/entities/product_info_entity.dart';

class ProductMapper {
  ProductInfoEntity mapToEntity(ProductInfoModel productInfoModel) {
    List<IngredientEntity> ingredients = [];
    for (int index = 0; index < productInfoModel.ingredients!.length; index++) {
      IngredientEntity ingredient = IngredientEntity(
        id: productInfoModel.ingredients?[index].id,
        percentEstimate: productInfoModel.ingredients?[index].percentEstimate,
        percentMax: productInfoModel.ingredients?[index].percentMax,
        percentMin: productInfoModel.ingredients?[index].percentMin,
        text: productInfoModel.ingredients?[index].text,
        vegan: productInfoModel.ingredients?[index].vegan,
        vegetarian: productInfoModel.ingredients?[index].vegetarian,
      );
      ingredients.add(ingredient);
    }
    return ProductInfoEntity(
      code: productInfoModel.code,
      productName: productInfoModel.productName,
      ingredients: ingredients,
      ingredientsText: productInfoModel.ingredientsText,
      labels: productInfoModel.labels,
      imageFrontUrl: productInfoModel.imageFrontUrl,
      proteins: productInfoModel.nutriments?.proteins,
      proteins100G: productInfoModel.nutriments?.proteins100G,
      proteinsUnit: productInfoModel.nutriments?.proteinsUnit,
      proteinsValue: productInfoModel.nutriments?.proteinsValue,
      carbohydrates: productInfoModel.nutriments?.carbohydrates,
      carbohydrates100G: productInfoModel.nutriments?.carbohydrates100G,
      carbohydratesUnit: productInfoModel.nutriments?.carbohydratesUnit,
      carbohydratesValue: productInfoModel.nutriments?.carbohydratesValue,
      fat: productInfoModel.nutriments?.fat,
      fat100G: productInfoModel.nutriments?.fat100G,
      fatUnit: productInfoModel.nutriments?.fatUnit,
      fatValue: productInfoModel.nutriments?.fatValue,
    );
  }
}
