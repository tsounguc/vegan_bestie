import 'package:equatable/equatable.dart';

class FoodProduct extends Equatable {
  const FoodProduct({
    required this.code,
    required this.productName,
    required this.ingredients,
    required this.ingredientsText,
    required this.labels,
    required this.imageFrontUrl,
    required this.nutriments,
  });

  FoodProduct.empty()
      : this(
          code: '_empty.code',
          productName: '_empty.productName',
          ingredients: [],
          ingredientsText: '_empty.',
          labels: '_empty.',
          imageFrontUrl: '_empty.',
          nutriments: const Nutriments.empty(),
        );

  final String code;
  final String productName;
  final List<Ingredient> ingredients;
  final String ingredientsText;
  final String labels;
  final String imageFrontUrl;
  final Nutriments nutriments;

  @override
  List<Object?> get props => [
        code,
        productName,
        ingredients,
        ingredientsText,
        labels,
        imageFrontUrl,
        nutriments,
      ];
}

class Nutriments extends Equatable {
  const Nutriments({
    required this.proteins,
    required this.proteins100G,
    required this.proteinsUnit,
    required this.proteinsValue,
    required this.carbohydrates,
    required this.carbohydrates100G,
    required this.carbohydratesUnit,
    required this.carbohydratesValue,
    required this.fat,
    required this.fat100G,
    required this.fatUnit,
    required this.fatValue,
  });

  const Nutriments.empty()
      : this(
          proteins: 0,
          proteins100G: 0,
          proteinsUnit: '_empty.',
          proteinsValue: 0,
          carbohydrates: 0,
          carbohydrates100G: 0,
          carbohydratesUnit: '_empty.carbohydratesUnit',
          carbohydratesValue: 0,
          fat: 0,
          fat100G: 0,
          fatUnit: '_empty.',
          fatValue: 0,
        );

  final double proteins;
  final double proteins100G;
  final String proteinsUnit;
  final double proteinsValue;
  final double carbohydrates;
  final double carbohydrates100G;
  final String carbohydratesUnit;
  final double carbohydratesValue;
  final double fat;
  final double fat100G;
  final String fatUnit;
  final double fatValue;

  @override
  List<Object?> get props => [
        proteins,
        proteins100G,
        proteinsUnit,
        proteinsValue,
        carbohydrates,
        carbohydrates100G,
        carbohydratesUnit,
        carbohydratesValue,
        fat,
        fat100G,
        fatUnit,
        fatValue,
      ];
}

class Ingredient extends Equatable {
  const Ingredient({
    required this.id,
    required this.ingredients,
    required this.percentEstimate,
    required this.percentMax,
    required this.percentMin,
    required this.text,
    required this.vegan,
    required this.vegetarian,
  });

  Ingredient.empty()
      : this(
          id: '_empty.id',
          ingredients: [],
          percentEstimate: 0,
          percentMax: 0,
          percentMin: 0,
          text: '_empty.text',
          vegan: '_empty.vegan',
          vegetarian: '_empty.vegetarian',
        );

  final String id;
  final List<Ingredient> ingredients;

  final double percentEstimate;
  final double percentMax;
  final double percentMin;
  final String text;
  final String vegan;
  final String vegetarian;

  @override
  List<Object?> get props => [
        id,
        ingredients,
        percentEstimate,
        percentMax,
        percentMin,
        text,
        vegan,
        vegetarian,
      ];
}
