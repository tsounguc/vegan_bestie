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
    required super.nutriments,
    required super.isVegan,
    required super.isVegetarian,
    required super.nonVeganIngredients,
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
          nutriments: const NutrimentsModel.empty(),
          isVegan: false,
          isVegetarian: false,
          nonVeganIngredients: '_empty.nonVeganIngredients',
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
          ingredients: dataMap['ingredients'] == null
              ? []
              : List<IngredientModel>.from(
                  (dataMap['ingredients'] as List).map(
                    (ingredient) => IngredientModel.fromMap(ingredient as DataMap),
                  ),
                ),
          ingredientsText: dataMap['ingredients_text'] == null ? '' : dataMap['ingredients_text'] as String,
          labels: dataMap['labels'] == null ? '' : dataMap['labels'] as String,
          imageFrontUrl: dataMap['image_front_url'] == null ? '' : dataMap['image_front_url'] as String,
          nutriments: dataMap['nutriments'] == null
              ? const NutrimentsModel.empty()
              : NutrimentsModel.fromMap(dataMap['nutriments'] as DataMap),
          isVegan: false,
          isVegetarian: false,
          nonVeganIngredients: '',
          id: dataMap['_id'] == null ? '' : dataMap['_id'] as String,
          keywords: dataMap['_keywords'] == null ? [] : List<String>.from(dataMap['_keywords'] as List),
          imageFrontSmallUrl:
              dataMap['image_front_small_url'] == null ? '' : dataMap['image_front_small_url'] as String,
          imageFrontThumbUrl:
              dataMap['image_front_thumb_url'] == null ? '' : dataMap['image_front_thumb_url'] as String,
          imageIngredientsSmallUrl:
              dataMap['image_ingredients_url'] == null ? '' : dataMap['image_ingredients_small_url'] as String,
          imageIngredientsThumbUrl: dataMap['image_ingredients_thumb_url'] == null
              ? ''
              : dataMap['image_ingredients_thumb_url'] as String,
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
          quantity: dataMap['quantity'] == null ? '' : dataMap['quantity'].toString(),
          servingQuantity: dataMap['serving_quantity'] == null ? '' : dataMap['serving_quantity'].toString(),
          servingSize: dataMap['serving_size'] == null ? '' : dataMap['serving_size'].toString(),
        );

  FoodProductModel copyWith({
    String? code,
    String? productName,
    List<Ingredient>? ingredients,
    String? ingredientsText,
    String? labels,
    String? imageFrontUrl,
    Nutriments? nutriments,
    bool? isVegan,
    bool? isVegetarian,
    String? nonVeganIngredients,
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
      nutriments: nutriments ?? this.nutriments,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      nonVeganIngredients: nonVeganIngredients ?? this.nonVeganIngredients,
      id: id ?? this.id,
      keywords: keywords ?? this.keywords,
      imageFrontSmallUrl: imageFrontSmallUrl ?? this.imageFrontSmallUrl,
      imageFrontThumbUrl: imageFrontThumbUrl ?? this.imageFrontThumbUrl,
      imageIngredientsSmallUrl: imageIngredientsSmallUrl ?? this.imageIngredientsSmallUrl,
      imageIngredientsThumbUrl: imageIngredientsThumbUrl ?? this.imageIngredientsThumbUrl,
      imageIngredientsUrl: imageIngredientsUrl ?? this.imageIngredientsUrl,
      imageNutritionSmallUrl: imageNutritionSmallUrl ?? this.imageNutritionSmallUrl,
      imageNutritionThumbUrl: imageNutritionThumbUrl ?? this.imageNutritionThumbUrl,
      imageNutritionUrl: imageNutritionUrl ?? this.imageNutritionUrl,
      imageSmallUrl: imageSmallUrl ?? this.imageSmallUrl,
      imageThumbUrl: imageThumbUrl ?? this.imageThumbUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      servingQuantity: this.servingQuantity,
      servingSize: servingSize ?? this.servingSize,
    );
  }

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'code': code,
        'product_name': productName,
        'ingredients': List<dynamic>.from(
          ingredients.map(
            (ingredient) => (ingredient as IngredientModel).toMap(),
          ),
        ),
        'ingredients_text': ingredientsText,
        'labels': labels,
        'image_front_url': imageFrontUrl,
        'nutriments': (nutriments as NutrimentsModel).toMap(),
        'isVegan': isVegan,
        'isVegetarian': isVegetarian,
        'nonVeganIngredients': nonVeganIngredients,
        '_id': id,
        '_keywords': keywords,
        'image_front_small_url': imageFrontSmallUrl,
        'image_front_thumb_url': imageFrontThumbUrl,
        'image_ingredients_small_url': imageIngredientsSmallUrl,
        'image_ingredients_thumb_url': imageIngredientsThumbUrl,
        'image_ingredients_url': imageIngredientsUrl,
        'image_nutrition_small_url': imageNutritionSmallUrl,
        'image_nutrition_thumb_url': imageNutritionThumbUrl,
        'image_nutrition_url': imageNutritionUrl,
        'image_small_url': imageSmallUrl,
        'image_thumb_url': imageThumbUrl,
        'image_url': imageUrl,
        'quantity': quantity,
        'serving_quantity': servingQuantity,
        'serving_size': servingSize,
      };

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

class NutrimentsModel extends Nutriments {
  const NutrimentsModel({
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
  });

  const NutrimentsModel.empty()
      : this(
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
        );

  factory NutrimentsModel.fromJson(String source) => NutrimentsModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  NutrimentsModel.fromMap(DataMap dataMap)
      : this(
          proteins: double.tryParse(dataMap['proteins'].toString()) ?? 0.0,
          proteins100G: double.tryParse(
                dataMap['proteins_100g'].toString(),
              ) ??
              0,
          proteinsUnit: dataMap['proteins_unit'] == null ? '' : dataMap['proteins_unit'] as String,
          proteinsValue: double.tryParse(dataMap['proteins_value'].toString()) ?? 0.0,
          carbohydrates: double.tryParse(
                dataMap['carbohydrates'].toString(),
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
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'proteins': proteins,
        'proteins_100g': proteins100G,
        'proteins_unit': proteinsUnit,
        'proteins_value': proteinsValue,
        'carbohydrates': carbohydrates,
        'carbohydrates_100g': carbohydrates100G,
        'carbohydrates_unit': carbohydratesUnit,
        'carbohydrates_value': carbohydratesValue,
        'fat': fat,
        'fat_100g': fat100G,
        'fat_unit': fatUnit,
        'fat_value': fatValue,
      };
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

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'id': id,
        'ingredients': List<dynamic>.from(
          ingredients.map(
            (ingredient) => (ingredient as IngredientModel).toMap(),
          ),
        ),
        'percent_estimate': percentEstimate,
        'percent_max': percentMax,
        'percent_min': percentMin,
        'text': text,
        'vegan': vegan,
        'vegetarian': vegetarian,
      };
}
