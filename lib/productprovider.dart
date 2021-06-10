import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/product.dart';

class ProductStateNotifier extends StateNotifier<ProductInfo> {
  ProductStateNotifier() : super(ProductInfo());

  String? error;
  String? imageUrl;
  String? barcode;
  String? productName;
  List<Ingredient>? ingredients;
  String? ingredientsText;
  String? labels;
  bool sheVegan = true;

  String nonVeganIngredientsInProduct = "";
  List<String> nonVeganIngredients = [
    "anchovies",
    "bee pollen",
    "bee venom",
    "beef",
    "beeswax",
    "butter",
    "calamari",
    "carmine",
    "casein",
    "castoreum",
    "cheese",
    "chicken",
    "cochineal",
    "crab",
    "cream",
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
    "lobster",
    "milk",
    "mussels",
    // "omega-3 fatty acids",
    "organ meat",
    "pork",
    "propolis",
    "quail",
    "royal jelly",
    "scallops",
    "shellac",
    "shrimp",
    "squid",
    "turkey",
    "veal",
    "vitamin d3",
    "whey",
    "wild meat",
    "yogurt",
  ];

  Future scan(BuildContext context) async {
    try {
      barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Cancel', true, ScanMode.BARCODE);
      print("Barcode: " + barcode!);

      if (barcode!.isNotEmpty) {
        Product? product = await getProduct(context);
        initState(product!);
        state = ProductInfo(
          barcode: barcode,
          productName: productName,
          ingredients: ingredientsText,
          labels: labels,
          imageUrl: imageUrl,
          error: error,
        );
        veganCheck(context);
      }
    } on PlatformException catch (e) {
      print("PlatformException: $e");
    }
  }

  void initState(Product product) {
    error = "";
    if (product.productName == null) {
      productName = '';
    } else {
      productName = product.productName;
    }

    if (product.ingredients == null) {
      ingredients = [];
      ingredientsText = "";
    } else {
      ingredients = product.ingredients;
      ingredientsText = product.ingredientsText;
    }

    if (product.labels == null) {
      labels = '';
    } else {
      labels = product.labels;
    }
    if (product.imageFrontUrl != null) {
      imageUrl = product.imageFrontUrl;
      print(imageUrl);
    } else if (product.imageFrontSmallUrl != null) {
      imageUrl = product.imageFrontSmallUrl;
      print(imageUrl);
    } else if (product.imageNutritionUrl != null) {
      imageUrl = product.imageFrontSmallUrl;
      print(imageUrl);
    } else if (product.imageNutritionSmallUrl != null) {
      imageUrl = product.imageNutritionSmallUrl;
      print(imageUrl);
    } else {
      imageUrl = '';
    }
  }

  Future<Product?> getProduct(BuildContext context) async {
    try {
      ProductQueryConfiguration configuration = ProductQueryConfiguration(
          barcode!,
          language: OpenFoodFactsLanguage.ENGLISH,
          fields: [ProductField.ALL]);
      ProductResult result = await OpenFoodAPIClient.getProduct(configuration);
      if (result.status != 1) {
        error = result.statusVerbose!;
        state = ProductInfo(
          barcode: "",
          imageUrl: "",
          productName: "",
          ingredients: "",
          labels: "",
          error: error,
        );

        throw Exception('Error retrieving the product: ' + error!);
      }
      return result.product;
    } on Exception catch (e) {
      final snackBar = SnackBar(
        backgroundColor: Colors.amber,
        content: Text(error!),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void veganCheck(BuildContext context) {
    sheVegan = true;
    if (labels!.isEmpty) {
      ingredients!.forEach((ingredient) {
        print(ingredient.text);
        print(ingredient.vegan);
        if (ingredient.vegan == null ||
            ingredient.vegan == IngredientSpecialPropertyStatus.NEGATIVE) {
          nonVeganIngredients.forEach((nonVeganIngredient) {
            if (ingredient.text == nonVeganIngredient) {
              nonVeganIngredientsInProduct = nonVeganIngredientsInProduct + "${ingredient.text!},  " ;
              sheVegan = false;
            }
          });
        }
      });
    } else if (!(labels!.toLowerCase().contains('vegan') ||
        labels!.toLowerCase().contains('contains no animal ingredients'))) {
      ingredients!.forEach((ingredient) {
        print(ingredient.text);
        print(ingredient.vegan);
        if (ingredient.vegan == null ||
            ingredient.vegan == IngredientSpecialPropertyStatus.NEGATIVE) {
          nonVeganIngredients.forEach((nonVeganIngredient) {
            if (ingredient.text == nonVeganIngredient) {
              sheVegan = false;
            }
          });
        }
      });
    }
    if (sheVegan == true) {
      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guuurl you know she ',
            ),
            Icon(
              VeganIcon.vegan_icon,
              color: Colors.white,
            ),
            Text(
              'egan! 😊',
            ),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (!sheVegan) {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Girl she ain\'t',
            ),
            Icon(
              VeganIcon.vegan_icon,
              color: Colors.white,
            ),
            Text(
              'egan 😞',
            ),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

final productProvider = StateNotifierProvider<ProductStateNotifier>(
    (ref) => new ProductStateNotifier());
