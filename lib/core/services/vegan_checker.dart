import 'package:flutter/material.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';

class VeganChecker {
  String nonVeganIngredientsInProduct = '';
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

  bool veganCheck(FoodProduct product) {
    debugPrint('ingredients: ${product.ingredientsText}');
    var ingredientsText = product.ingredientsText;
    if (ingredientsText.isNotEmpty && ingredientsText.substring(ingredientsText.length - 1) == ',') {
      ingredientsText = product.ingredientsText.substring(
        0,
        ingredientsText.lastIndexOf(','),
      );
    }
    var isVegan = true;
    nonVeganIngredientsInProduct = '';
    var ingredientListFromText = <String>[];
    if (ingredientsText.contains(',')) {
      ingredientsText = ingredientsText.replaceAll('(', ',');
      ingredientsText = ingredientsText.replaceAll(')', '');
      ingredientListFromText = ingredientsText.split(',')..forEach(debugPrint);
    }
    // Ingredients not found in the data base
    if (product.ingredients.isEmpty) {
      isVegan = false;
    }
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
              nonVeganIngredientsInProduct = '$nonVeganIngredientsInProduct'
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
          nonVeganIngredientsInProduct = '$nonVeganIngredientsInProduct'
              '${ingredient.text.toLowerCase()}, ';
          isVegan = false;
        }
      }
      debugPrint('Ingredients from text');
      for (final nonVeganIngredient in nonVeganIngredients) {
        for (final ingredient in ingredientListFromText) {
          if (ingredient.toLowerCase().trim() == nonVeganIngredient.toLowerCase().trim() &&
              !nonVeganIngredientsInProduct.contains('$nonVeganIngredient, ')) {
            debugPrint(
              '$ingredient is text and '
              '$nonVeganIngredient is from non vegan list',
            );
            nonVeganIngredientsInProduct = '$nonVeganIngredientsInProduct'
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
              nonVeganIngredientsInProduct = '$nonVeganIngredientsInProduct'
                  '${ingredient.text.toLowerCase()}, ';
              isVegan = false;
            }
          }
        }
        // ingredient vegan status is no
        // set isVegan to false and add it to string of nonVegan ingredients found in product
        if (ingredient.vegan == 'no') {
          debugPrint('is ${ingredient.text} vegan: ${ingredient.vegan}');
          nonVeganIngredientsInProduct = '$nonVeganIngredientsInProduct'
              '${ingredient.text.toLowerCase()}, ';
          isVegan = false;
        }
      }
      for (final nonVeganIngredient in nonVeganIngredients) {
        for (final ingredient in ingredientListFromText) {
          if (ingredient.toLowerCase().trim() == nonVeganIngredient.toLowerCase().trim() &&
              !nonVeganIngredientsInProduct.contains('$nonVeganIngredient, ')) {
            debugPrint('$ingredient is text and '
                '$nonVeganIngredient is from non vegan list');
            nonVeganIngredientsInProduct = '$nonVeganIngredientsInProduct'
                '$nonVeganIngredient, ';
            isVegan = false;
          }
        }
      }
    }
    if (nonVeganIngredientsInProduct.contains(', ')) {
      final lastCommaIndex = nonVeganIngredientsInProduct.lastIndexOf(', ');
      nonVeganIngredientsInProduct = nonVeganIngredientsInProduct.substring(
        0,
        lastCommaIndex,
      );
    }
    debugPrint('Non Vegan ingredients: $nonVeganIngredientsInProduct');
    return isVegan;
  }
}
