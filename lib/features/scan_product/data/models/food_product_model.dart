import 'dart:convert';

import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';

class FoodProductModel extends FoodProduct {
  const FoodProductModel({
    required super.code,
    required super.productName,
    required super.ingredients,
    required super.ingredientsText,
    required super.labels,
    required super.imageFrontUrl,
    required super.proteins,
    required super.proteins100G,
    required super.proteinsUnit,
    required super.proteinsValue,
    required super.carbohydrates,
    required super.carbohydrates100G,
    required super.carbohydratesUnit,
    required super.carbohydratesValue,
    required super.fat,
    required super.fat100G,
    required super.fatUnit,
    required super.fatValue,
    this.id,
    this.keywords,
    this.imageFrontSmallUrl,
    this.imageFrontThumbUrl,
    this.imageIngredientsSmallUrl,
    this.imageIngredientsThumbUrl,
    this.imageIngredientsUrl,
    this.imageNutritionSmallUrl,
    this.imageNutritionThumbUrl,
    this.imageNutritionUrl,
    this.imageSmallUrl,
    this.imageThumbUrl,
    this.imageUrl,
    this.quantity,
    this.servingQuantity,
    this.servingSize,
  });

  FoodProductModel.empty()
      : this(
          code: '_empty.code',
          productName: '_empty.productName',
          ingredients: [],
          ingredientsText: '_empty.ingredientsText',
          labels: '_empty.labels',
          imageFrontUrl: '_empty.imageFrontUrl',
          proteins: 0,
          proteins100G: 0,
          proteinsUnit: '_empty.proteinsUnit',
          proteinsValue: 0,
          carbohydrates: 0,
          carbohydrates100G: 0,
          carbohydratesUnit: '_empty.carbohydratesUnit',
          carbohydratesValue: 0,
          fat: 0,
          fat100G: 0,
          fatUnit: '_empty.fatUnit',
          fatValue: 0,
          id: '_empty.id',
          keywords: [],
          imageFrontSmallUrl: '_empty.imageFrontSmallUrl',
          imageFrontThumbUrl: '_empty.imageFrontThumbUrl',
          imageIngredientsSmallUrl: '_empty.imageIngredientsSmallUrl',
          imageIngredientsThumbUrl: '_empty.imageIngredientsThumbUrl',
          imageIngredientsUrl: '_empty.imageIngredientsUrl',
          imageNutritionSmallUrl: '_empty.imageNutritionSmallUrl',
          imageNutritionThumbUrl: '_empty.imageNutritionThumbUrl',
          imageNutritionUrl: '_empty.imageNutritionUrl',
          imageSmallUrl: '_empty.imageSmallUrl',
          imageThumbUrl: '_empty.imageThumbUrl',
          imageUrl: '_empty.imageUrl',
          quantity: '_empty.quantity',
          servingQuantity: '_empty.servingQuantity',
          servingSize: '_empty.servingSize',
        );

  factory FoodProductModel.fromJson(String source) => FoodProductModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  FoodProductModel.fromMap(DataMap dataMap)
      : this(
          code: dataMap['code'] == null ? '' : dataMap['code'] as String,
          productName: dataMap['product_name'] == null ? '' : dataMap['product_name'] as String,
          ingredients: List<IngredientModel>.from(
            (dataMap['ingredients'] as List).map(
              (ingredient) => IngredientModel.fromMap(ingredient as DataMap),
            ),
          ),
          ingredientsText: dataMap['ingredients_text'] == null ? '' : dataMap['ingredients_text'] as String,
          labels: dataMap['labels'] == null ? '' : dataMap['labels'] as String,
          imageFrontUrl: dataMap['image_front_url'] == null ? '' : dataMap['image_front_url'] as String,
          proteins: double.tryParse(dataMap['proteins'].toString()) ?? 0.0,
          proteins100G: double.tryParse(
                dataMap['proteins_100g'].toString(),
              ) ??
              0,
          proteinsUnit: dataMap['protein_unit'] == null ? '' : dataMap['protein_unit'] as String,
          proteinsValue: double.tryParse(dataMap['proteins_value'].toString()) ?? 0.0,
          carbohydrates: double.tryParse(
                dataMap['proteins_100g'].toString(),
              ) ??
              0.0,
          carbohydrates100G: double.tryParse(
                dataMap['carbohydrates_100g'].toString(),
              ) ??
              0.0,
          carbohydratesUnit: dataMap['carbohydrates_unit'] == null ? '' : dataMap['carbohydrates_unit'] as String,
          carbohydratesValue: double.tryParse(
                dataMap['carbohydrates_value'].toString(),
              ) ??
              0.0,
          fat: double.tryParse(dataMap['fat'].toString()) ?? 0.0,
          fat100G: double.tryParse(dataMap['fat_100g'].toString()) ?? 0.0,
          fatUnit: dataMap['fat_unit'] == null ? '' : dataMap['fat_unit'] as String,
          fatValue: double.tryParse(dataMap['fat_value'].toString()) ?? 0.0,
          id: dataMap['id'] == null ? '' : dataMap['id'] as String,
          keywords: dataMap['keywords'] == null ? [] : List<String>.from(dataMap['keywords'] as List),
          imageFrontSmallUrl:
              dataMap['image_front_small_url'] == null ? '' : dataMap['image_front_small_url'] as String,
          imageFrontThumbUrl:
              dataMap['image_front_thumb_url'] == null ? '' : dataMap['image_front_thumb_url'] as String,
          imageIngredientsSmallUrl:
              dataMap['image_ingredients_url'] == null ? '' : dataMap['image_ingredients_small_url'] as String,
          imageIngredientsThumbUrl:
              dataMap['image_nutrition_thumb_url'] == null ? '' : dataMap['image_ingredients_thumb_url'] as String,
          imageIngredientsUrl:
              dataMap['image_ingredients_url'] == null ? '' : dataMap['image_ingredients_url'] as String,
          imageNutritionSmallUrl:
              dataMap['image_nutrition_small_url'] == null ? '' : dataMap['image_nutrition_small_url'] as String,
          imageNutritionThumbUrl:
              dataMap['image_nutrition_thumb_url'] == null ? '' : dataMap['image_nutrition_thumb_url'] as String,
          imageNutritionUrl:
              dataMap['image_nutrition_url'] == null ? '' : dataMap['image_nutrition_url'] as String,
          imageSmallUrl: dataMap['image_small_url'] == null ? '' : dataMap['image_small_url'] as String,
          imageThumbUrl: dataMap['image_thumb_url'] == null ? '' : dataMap['image_thumb_url'] as String,
          imageUrl: dataMap['image_url'] == null ? '' : dataMap['image_url'] as String,
          quantity: dataMap['quantity'] == null ? '' : dataMap['quantity'] as String,
          servingQuantity: dataMap['serving_quantity'] == null ? '' : dataMap['serving_quantity'] as String,
          servingSize: dataMap['serving_size'] == null ? '' : dataMap['serving_size'] as String,
        );

  FoodProductModel copyWith({
    String? code,
    String? productName,
    List<Ingredient>? ingredients,
    String? ingredientsText,
    String? labels,
    String? imageFrontUrl,
    double? proteins,
    double? proteins100G,
    String? proteinsUnit,
    double? proteinsValue,
    double? carbohydrates,
    double? carbohydrates100G,
    String? carbohydratesUnit,
    double? carbohydratesValue,
    double? fat,
    double? fat100G,
    String? fatUnit,
    double? fatValue,
    String? id,
    List<String>? keywords,
    String? imageFrontSmallUrl,
    String? imageFrontThumbUrl,
    String? imageIngredientsSmallUrl,
    String? imageIngredientsThumbUrl,
    String? imageIngredientsUrl,
    String? imageNutritionSmallUrl,
    String? imageNutritionThumbUrl,
    String? imageNutritionUrl,
    String? imageSmallUrl,
    String? imageThumbUrl,
    String? imageUrl,
    String? quantity,
    double? servingQuantity,
    String? servingSize,
  }) {
    return FoodProductModel(
      code: code ?? this.code,
      productName: productName ?? this.productName,
      ingredients: ingredients ?? this.ingredients,
      ingredientsText: ingredientsText ?? this.ingredientsText,
      labels: labels ?? this.labels,
      imageFrontUrl: imageFrontUrl ?? this.imageFrontUrl,
      proteins: proteins ?? this.proteins,
      proteins100G: proteins100G ?? this.proteins100G,
      proteinsUnit: proteinsUnit ?? this.proteinsUnit,
      proteinsValue: proteinsValue ?? this.proteinsValue,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      carbohydrates100G: carbohydrates100G ?? this.carbohydrates100G,
      carbohydratesUnit: carbohydratesUnit ?? this.carbohydratesUnit,
      carbohydratesValue: carbohydratesValue ?? this.carbohydratesValue,
      fat: fat ?? this.fat,
      fat100G: fat100G ?? this.fat100G,
      fatUnit: fatUnit ?? this.fatUnit,
      fatValue: fatValue ?? this.fatValue,
    );
  }

  final String? id;
  final List<String>? keywords;
  final String? imageFrontSmallUrl;
  final String? imageFrontThumbUrl;
  final String? imageIngredientsSmallUrl;
  final String? imageIngredientsThumbUrl;
  final String? imageIngredientsUrl;
  final String? imageNutritionSmallUrl;
  final String? imageNutritionThumbUrl;
  final String? imageNutritionUrl;
  final String? imageSmallUrl;
  final String? imageThumbUrl;
  final String? imageUrl;
  final String? quantity;
  final String? servingQuantity;
  final String? servingSize;
}

class IngredientModel extends Ingredient {
  const IngredientModel({
    required super.id,
    required super.ingredients,
    required super.percentEstimate,
    required super.percentMax,
    required super.percentMin,
    required super.text,
    required super.vegan,
    required super.vegetarian,
  });

  factory IngredientModel.fromJson(String source) => IngredientModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  IngredientModel.fromMap(DataMap dataMap)
      : this(
          id: dataMap['id'] == null ? '' : dataMap['id'] as String,
          ingredients: dataMap['ingredients'] == null
              ? []
              : List<IngredientModel>.from(
                  (dataMap['ingredients'] as List).map(
                    (ingredient) => IngredientModel.fromMap(
                      ingredient as DataMap,
                    ),
                  ),
                ),
          percentEstimate: double.tryParse(dataMap['percent_estimate'].toString()) ?? 0.0,
          percentMax: double.tryParse(dataMap['percent_max'].toString()) ?? 0.0,
          percentMin: double.tryParse(dataMap['person_min'].toString()) ?? 0.0,
          text: dataMap['text'] == null ? '' : dataMap['text'] as String,
          vegan: dataMap['vegan'] == null ? '' : dataMap['vegan'] as String,
          vegetarian: dataMap['vegetarian'] == null ? '' : dataMap['vegetarian'] as String,
        );
}
