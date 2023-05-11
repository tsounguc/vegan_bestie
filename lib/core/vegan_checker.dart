import 'package:flutter/material.dart';

class VeganChecker {
  String _nonVeganIngredientsInProduct = "";
  List<String> nonVeganIngredients = [
    "acidophilus Milk",
    "anchovies",
    "bee pollen",
    "bee venom",
    "beef",
    "beeswax",
    "butter",
    "butter extract",
    "butter fat",
    "butter solids",
    "buttermilk",
    "buttermilk blend",
    "buttermilk solids",
    "boar bristles",
    "bone",
    "bone char",
    "bone meal",
    "calamari",
    "carmine",
    "casein",
    "castoreum",
    "cheese",
    "chicken",
    "cochineal",
    "collagen",
    "collagen peptides",
    "crab",
    "cream",
    "dairy butter",
    "duck",
    "edible bone phosphate",
    "eggs",
    "fish",
    "fish sauce",
    "gelatin",
    "goose",
    "honey",
    "horse",
    "isinglass",
    "l-cysteine",
    "lamb",
    "lactose",
    "lactose-free milk",
    "lobster",
    "malted milk",
    "milk",
    "milk derivative",
    "milk protein",
    "milk powder",
    "milk skimmed",
    "milk skimmed powder",
    "milk skimmed powder 8",
    "milk solids",
    "milk solids blend",
    "mussels",
    "natural butter",

    // "omega-3 fatty acids",
    "organ meat",
    "pork",
    "propolis",
    "quail",
    "royal jelly",
    "scallops",
    "shellac",
    "shrimp",
    "skim milk",
    "skim milk powder",
    "skim milk powder 8",
    "skimmed milk",
    "skimmed milk powder",
    "skimmed milk powder 8",
    "sour milk",
    "squid",
    "turkey",
    "veal",
    "vitamin d3",
    "whey",
    "whipped butter",
    "whole egg",
    "whole egg solids",
    "whole eggs",
    "whole eggs solid",
    "wild meat",
    "yogurt",
  ];

  String get nonVeganIngredientsInProduct => _nonVeganIngredientsInProduct;

  set nonVeganIngredientsInProduct(String value) {
    _nonVeganIngredientsInProduct = value;
  }

  bool veganCheck(productEntity) {
    bool isVegan = true;
    _nonVeganIngredientsInProduct = "";
    if (productEntity?.ingredients == null || productEntity?.ingredients.isEmpty) {
      isVegan = false;
    }
    if (productEntity?.labels == null || productEntity!.labels!.isEmpty) {
      productEntity!.ingredients?.forEach((ingredient) {
        if (ingredient.vegan == null || ingredient.vegan == "maybe") {
          nonVeganIngredients.forEach((nonVeganIngredient) {
            if (ingredient.text!.toLowerCase() == nonVeganIngredient.toLowerCase()) {
              _nonVeganIngredientsInProduct =
                  _nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
              isVegan = false;
            }
          });
        }
        if (ingredient.vegan == "no") {
          _nonVeganIngredientsInProduct = _nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
          isVegan = false;
        }
      });
    } else if (!(productEntity.labels!.toLowerCase().contains('vegan') ||
        productEntity.labels!.toLowerCase().contains('contains no animal ingredients'))) {
      productEntity.ingredients?.forEach((ingredient) {
        debugPrint("is ${ingredient.text} vegan: ${ingredient.vegan}");
        if (ingredient.vegan == null || ingredient.vegan == "maybe") {
          nonVeganIngredients.forEach((nonVeganIngredient) {
            if (ingredient.text!.toLowerCase() == nonVeganIngredient.toLowerCase()) {
              _nonVeganIngredientsInProduct =
                  _nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
              isVegan = false;
            }
          });
        }
        if (ingredient.vegan == "no") {
          nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!.toLowerCase()}, ";
          isVegan = false;
        }
      });
    }
    if (nonVeganIngredientsInProduct.contains(", ")) {
      int lastCommaIndex = nonVeganIngredientsInProduct.lastIndexOf(", ");
      nonVeganIngredientsInProduct = nonVeganIngredientsInProduct.substring(0, lastCommaIndex);
    }
    debugPrint("Non Vegan ingredients: " + nonVeganIngredientsInProduct);
    return isVegan;
  }
}
