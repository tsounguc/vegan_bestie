import 'package:flutter/material.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';

class VeganChecker {
  List<String> nonVeganIngredients = [
    'acidophilus milk',
    'anchovies',
    'bee pollen',
    'bee venom',
    'beef',
    'beef broth',
    'beef broth base',
    'beef fat',
    'beef extract',
    'beeswax',
    'butter',
    'butter extract',
    'butter fat',
    'butter solids',
    'buttermilk',
    'buttermilk blend',
    'buttermilk solids',
    'boar bristles',
    'bone',
    'bone char',
    'bone meal',
    'calamari',
    'carmine',
    'casein',
    'castoreum',
    'cheese',
    'chicken',
    'chicken broth',
    'chicken broth base',
    'chicken fat',
    'chicken extract',
    'cochineal',
    'collagen',
    'collagen peptides',
    'crab',
    'cream',
    'dairy butter',
    'duck',
    'duck broth',
    'duck broth base',
    'duck fat',
    'duck extract',
    'edible bone phosphate',
    'eggs',
    'fish',
    'fish sauce',
    'gelatin',
    'goose',
    'honey',
    'horse',
    'isinglass',
    'l-cysteine',
    'lamb',
    'lactose',
    'lactose-free milk',
    'lobster',
    'malted milk',
    'milk',
    'milk derivative',
    'milk protein',
    'milk powder',
    'milk skimmed',
    'milk skimmed powder',
    'milk skimmed powder 8',
    'milk solids',
    'milk solids blend',
    'mussels',
    'natural butter',
    'natural beef flavor',
    'natural beef flavors',
    'natural beef broth flavor',
    'natural beef broth flavor base',
    'natural beef broth base',
    // "natural chicken flavor",
    'natural chicken flavors',
    'natural chicken broth flavor',
    'natural chicken broth flavor base',
    'natural chicken broth base',
    'natural duck flavor',
    'natural duck flavors',
    'natural duck broth flavor',
    'natural duck broth flavor base',
    'natural duck broth base',
    'natural pork flavor',
    'natural pork flavors',
    'natural pork broth flavor',
    'natural pork broth flavor base',
    'natural pork broth base',
    'natural turkey flavor',
    'natural turkey flavors',
    'natural turkey broth flavor',
    'natural turkey broth flavor base',
    'natural turkey broth base',
    // "omega-3 fatty acids",
    'organ meat',
    'pork',
    'pork broth',
    'pork broth base',
    'pork fat',
    'pork extract',
    'propolis',
    'propolis extract',
    'quail',
    'royal jelly',
    'scallops',
    'shellac',
    'shrimp',
    'skim milk',
    'skim milk powder',
    'skim milk powder 8',
    'skimmed milk',
    'skimmed milk powder',
    'skimmed milk powder 8',
    'sour milk',
    'squid',
    'turkey',
    'turkey broth',
    'turkey broth base',
    'turkey fat',
    'turkey extract',
    'veal',
    'vitamin d3',
    'whey',
    'whipped butter',
    'whole egg',
    'whole egg solids',
    'whole eggs',
    'whole eggs solid',
    'wild meat',
    'yogurt',
  ];
  List<String> nonVegetarianIngredients = [
    'beef',
    'beef broth',
    'beef broth base',
    'beef fat',
    'beef extract',
    'bone',
    'bone char',
    'bone meal',
    'calamari',
    'carmine',
    'chicken',
    'chicken broth',
    'chicken broth base',
    'chicken fat',
    'chicken extract',
    'cochineal',
    'collagen',
    'collagen peptides',
    'crab',
    'duck',
    'duck broth',
    'duck broth base',
    'duck fat',
    'duck extract',
    'edible bone phosphate',
    'fish',
    'fish sauce',
    'gelatin',
    'goose',
    'horse',
    'isinglass',
    'lamb',
    'lobster',
    'natural beef flavor',
    'natural beef flavors',
    'natural beef broth flavor',
    'natural beef broth flavor base',
    'natural beef broth base',
    // "natural chicken flavor",
    'natural chicken flavors',
    'natural chicken broth flavor',
    'natural chicken broth flavor base',
    'natural chicken broth base',
    'natural duck flavor',
    'natural duck flavors',
    'natural duck broth flavor',
    'natural duck broth flavor base',
    'natural duck broth base',
    'natural pork flavor',
    'natural pork flavors',
    'natural pork broth flavor',
    'natural pork broth flavor base',
    'natural pork broth base',
    'natural turkey flavor',
    'natural turkey flavors',
    'natural turkey broth flavor',
    'natural turkey broth flavor base',
    'natural turkey broth base',
    'organ meat',
    'pork',
    'pork broth',
    'pork broth base',
    'pork fat',
    'pork extract',
    'quail',
    'royal jelly',
    'scallops',
    'shellac',
    'shrimp',
    'squid',
    'turkey',
    'turkey broth',
    'turkey broth base',
    'turkey fat',
    'turkey extract',
    'veal',
    'wild meat',
    'yogurt',
  ];

  String _nonVeganIngredientsInProduct = '';
  String _nonVegetarianIngredientsInProduct = '';

  String get nonVeganIngredientsInProduct => _nonVeganIngredientsInProduct;

  String get nonVegetarianIngredientsInProduct => _nonVegetarianIngredientsInProduct;

  bool veganCheck(FoodProduct product) {
    var isVegan = true;
    _nonVeganIngredientsInProduct = '';
    final ingredientListFromText = _getListOfIngredients(
      product.ingredientsText,
    );

    // List of Ingredients not found in the data base
    isVegan = product.ingredients.isNotEmpty;
    // Labels is empty or null
    if (product.labels.isEmpty) {
      debugPrint('Labels is empty or null');
      for (final ingredient in product.ingredients) {
        debugPrint('is ${ingredient.text} vegan: ${ingredient.vegan}');
        // ingredient vegan status unsure
        if (ingredient.vegan.isEmpty || ingredient.vegan == 'maybe') {
          for (final nonVeganIngredient in nonVeganIngredients) {
            // if ingredient is equal to ingredient in nonVeganIngredients list
            // set isVegan to false and
            // add it to string of nonVegan ingredients found in product
            if (ingredient.text.toLowerCase() == nonVeganIngredient.toLowerCase()) {
              _nonVeganIngredientsInProduct = '$_nonVeganIngredientsInProduct'
                  '${ingredient.text.toLowerCase()}, ';
              isVegan = false;
            }
          }
        }
        // ingredient vegan status is no
        // set isVegan to false and
        // add it to string of nonVegan ingredients found in product
        if (ingredient.vegan == 'no') {
          debugPrint(
            'is ${ingredient.text} vegan: ${ingredient.vegan.toUpperCase()}',
          );
          _nonVeganIngredientsInProduct = '$_nonVeganIngredientsInProduct'
              '${ingredient.text.toLowerCase()}, ';
          isVegan = false;
        }
      }
      debugPrint('Ingredients from text');
      for (final nonVeganIngredient in nonVeganIngredients) {
        for (final ingredient in ingredientListFromText) {
          if (ingredient.toLowerCase().trim() == nonVeganIngredient.toLowerCase().trim() &&
              !_nonVeganIngredientsInProduct.contains('$nonVeganIngredient, ')) {
            debugPrint(
              '$ingredient is text and '
              '$nonVeganIngredient is from non vegan list',
            );
            _nonVeganIngredientsInProduct = '$_nonVeganIngredientsInProduct'
                '$nonVeganIngredient, ';
            isVegan = false;
          }
        }
      }
    }
    // Labels list doesn't include Vegan or Contains no animal ingredients
    else if (!(product.labels.toLowerCase().contains('vegan') ||
        product.labels.toLowerCase().contains('contains no animal ingredients'))) {
      debugPrint("Labels list doesn't include Vegan "
          'or Contains no animal ingredients');
      for (final ingredient in product.ingredients) {
        debugPrint('is ${ingredient.text} vegan: ${ingredient.vegan}');
        // ingredient vegan status unsure
        if (ingredient.vegan.isEmpty || ingredient.vegan == 'maybe') {
          for (final nonVeganIngredient in nonVeganIngredients) {
            if (ingredient.text.toLowerCase() == nonVeganIngredient.toLowerCase()) {
              _nonVeganIngredientsInProduct = '$_nonVeganIngredientsInProduct'
                  '${ingredient.text.toLowerCase()}, ';
              isVegan = false;
            }
          }
        }
        // ingredient vegan status is no
        // set isVegan to false and add it to string of nonVegan ingredients found in product
        if (ingredient.vegan == 'no') {
          debugPrint('is ${ingredient.text} vegan: ${ingredient.vegan}');
          _nonVeganIngredientsInProduct = '$_nonVeganIngredientsInProduct'
              '${ingredient.text.toLowerCase()}, ';
          isVegan = false;
        }
      }
      for (final nonVeganIngredient in nonVeganIngredients) {
        for (final ingredient in ingredientListFromText) {
          if (ingredient.toLowerCase().trim() == nonVeganIngredient.toLowerCase().trim() &&
              !_nonVeganIngredientsInProduct.contains('$nonVeganIngredient, ')) {
            debugPrint('$ingredient is text and '
                '$nonVeganIngredient is from non vegan list');
            _nonVeganIngredientsInProduct = '$_nonVeganIngredientsInProduct'
                '$nonVeganIngredient, ';
            isVegan = false;
          }
        }
      }
    }
    if (_nonVeganIngredientsInProduct.contains(', ')) {
      final lastCommaIndex = _nonVeganIngredientsInProduct.lastIndexOf(', ');
      _nonVeganIngredientsInProduct = _nonVeganIngredientsInProduct.substring(
        0,
        lastCommaIndex,
      );
    }
    debugPrint('Non Vegan ingredients: $_nonVeganIngredientsInProduct');
    return isVegan;
  }

  bool vegetarianCheck(FoodProduct product) {
    var isVegetarian = true;
    _nonVegetarianIngredientsInProduct = '';
    final ingredientListFromText = _getListOfIngredients(
      product.ingredientsText,
    );

    // List of Ingredients not found in the data base
    isVegetarian = product.ingredients.isNotEmpty;
    // Labels is empty or null
    if (product.labels.isEmpty) {
      debugPrint('Labels is empty or null');
      for (final ingredient in product.ingredients) {
        debugPrint('is ${ingredient.text} vegetarian: ${ingredient.vegetarian}');
        // ingredient vegetarian status unsure
        if (ingredient.vegetarian.isEmpty || ingredient.vegetarian == 'maybe') {
          for (final nonVegetarianIngredient in nonVegetarianIngredients) {
            // if ingredient is equal to ingredient in nonVegetarianIngredients list
            // set isVegetarian to false and
            // add it to string of nonVegetarian ingredients found in product
            if (ingredient.text.toLowerCase() == nonVegetarianIngredient.toLowerCase()) {
              _nonVegetarianIngredientsInProduct = '$_nonVegetarianIngredientsInProduct'
                  '${ingredient.text.toLowerCase()}, ';
              isVegetarian = false;
            }
          }
        }
        // ingredient vegetarian status is no
        // set isVegetarian to false and
        // add it to string of nonVegetarian ingredients found in product
        if (ingredient.vegetarian == 'no') {
          debugPrint(
            'is ${ingredient.text} vegetarian: ${ingredient.vegetarian.toUpperCase()}',
          );
          _nonVegetarianIngredientsInProduct = '$_nonVegetarianIngredientsInProduct'
              '${ingredient.text.toLowerCase()}, ';
          isVegetarian = false;
        }
      }
      debugPrint('Ingredients from text');
      for (final nonVegetarianIngredient in nonVegetarianIngredients) {
        for (final ingredient in ingredientListFromText) {
          if (ingredient.toLowerCase().trim() == nonVegetarianIngredient.toLowerCase().trim() &&
              !_nonVegetarianIngredientsInProduct.contains('$nonVegetarianIngredient, ')) {
            debugPrint(
              '$ingredient is text and '
              '$nonVegetarianIngredient is from non vegetarian list',
            );
            _nonVegetarianIngredientsInProduct = '$_nonVegetarianIngredientsInProduct'
                '$nonVegetarianIngredient, ';
            isVegetarian = false;
          }
        }
      }
    }
    // Labels list doesn't include Vegan or Contains no animal ingredients
    else if (!product.labels.toLowerCase().contains('vegetarian')) {
      debugPrint("Labels list doesn't include Vegetarian");
      for (final ingredient in product.ingredients) {
        debugPrint('is ${ingredient.text} vegetarian: ${ingredient.vegetarian}');
        // ingredient vegetarian status unsure
        if (ingredient.vegetarian.isEmpty || ingredient.vegetarian == 'maybe') {
          for (final nonVegetarianIngredient in nonVegetarianIngredients) {
            if (ingredient.text.toLowerCase() == nonVegetarianIngredient.toLowerCase()) {
              _nonVegetarianIngredientsInProduct = '$_nonVegetarianIngredientsInProduct'
                  '${ingredient.text.toLowerCase()}, ';
              isVegetarian = false;
            }
          }
        }
        // ingredient vegetarian status is no
        // set isVegetarian to false and add it to string of nonVegetarian
        // ingredients found in product
        if (ingredient.vegetarian == 'no') {
          debugPrint('is ${ingredient.text} vegetarian: ${ingredient.vegetarian}');
          _nonVegetarianIngredientsInProduct = '$_nonVegetarianIngredientsInProduct'
              '${ingredient.text.toLowerCase()}, ';
          isVegetarian = false;
        }
      }
      for (final nonVegetarianIngredient in nonVegetarianIngredients) {
        for (final ingredient in ingredientListFromText) {
          if (ingredient.toLowerCase().trim() == nonVegetarianIngredient.toLowerCase().trim() &&
              !_nonVegetarianIngredientsInProduct.contains('$nonVegetarianIngredient, ')) {
            debugPrint('$ingredient is text and '
                '$nonVegetarianIngredient is from non vegan list');
            _nonVegetarianIngredientsInProduct = '$_nonVegetarianIngredientsInProduct'
                '$nonVegetarianIngredient, ';
            isVegetarian = false;
          }
        }
      }
    }
    if (_nonVegetarianIngredientsInProduct.contains(', ')) {
      final lastCommaIndex = _nonVegetarianIngredientsInProduct.lastIndexOf(', ');
      _nonVegetarianIngredientsInProduct = _nonVegetarianIngredientsInProduct.substring(
        0,
        lastCommaIndex,
      );
    }
    debugPrint('Non Vegetarian ingredients: $_nonVegetarianIngredientsInProduct');
    return isVegetarian;
  }

  List<String> _getListOfIngredients(String ingredients) {
    var ingredientsText = ingredients;
    var ingredientsList = <String>[];
    if (ingredientsText.isNotEmpty && ingredientsText.substring(ingredientsText.length - 1) == ',') {
      ingredientsText = ingredients.substring(
        0,
        ingredientsText.lastIndexOf(','),
      );
    }

    if (ingredientsText.contains(',')) {
      ingredientsText = ingredientsText.replaceAll('(', ',');
      ingredientsText = ingredientsText.replaceAll(')', '');
      ingredientsList = ingredientsText.split(',');
      // ..forEach(debugPrint);
    }

    return ingredientsList;
  }
}
