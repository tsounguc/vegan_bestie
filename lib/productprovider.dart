import 'package:cached_network_image/cached_network_image.dart';
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
  CachedNetworkImage? cachedNetworkImage;
  CachedNetworkImageProvider? imageProvider;
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
        print("barcode not empty");
        state = ProductInfo(loading: true);
        Product? product = await getProduct(context);
        initState(product!);
        // cachedNetworkImage = CachedNetworkImage(
        //   height: 250,
        //   width: 225,
        //   fit: BoxFit.fill,
        //   imageUrl: '$imageUrl',
        // );
        // imageProvider = CachedNetworkImageProvider(imageUrl!);
        state = ProductInfo(
          barcode: barcode,
          productName: productName,
          ingredients: ingredientsText,
          labels: labels,
          imageUrl: imageUrl,
          error: error,
          loading: false,
        );
        veganCheck(context);
      }
    } on PlatformException catch (e) {
      print("PlatformException: $e");
    }
  }

  void initState(Product product) {
    error = "";
    imageUrl = "";
    productName = "";
    ingredients = [];
    ingredientsText = "";
    labels = "";
    if (product.productName == null) {
      productName = '';
    } else {
      productName = product.productName;
    }

    if (product.ingredients == null) {
      ingredients = [];
      ingredientsText = "";
      error = '${product.productName} is missing ingredients list';
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
    cachedNetworkImage = CachedNetworkImage(
      height: 250,
      width: 225,
      fit: BoxFit.fill,
      imageUrl: '$imageUrl',
    );
    imageProvider = CachedNetworkImageProvider(imageUrl!);
    state = ProductInfo(
      barcode: barcode,
      imageUrl: imageUrl,
      productName: productName,
      ingredients: ingredientsText,
      labels: labels,
      error: error,
      loading: false,
    );
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
        print("Error message: $error");
        if (error!.contains("product not found")) {
          productName = "";
        }

        state = ProductInfo(
          barcode: barcode,
          imageUrl: "",
          productName: productName,
          ingredients: "",
          labels: "",
          error: error,
          loading: false,
        );

        throw Exception('Error retrieving the product: ' + error!);
      }
      print("product found: ${result.product!.productName}");

      return result.product;
    } on Exception catch (e) {
      final snackBar = SnackBar(
        // duration: Duration(seconds: 5),
        backgroundColor: Colors.amber,
        content: Text(error!),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void addNewProduct(
    String barcode,
    String productName,
    // String productImage,
    String ingredients,
  ) async {
    // define the product to be added.
    // more attributes available ...
    Product myProduct = Product(
      barcode: barcode,
      productName: productName,
      // imageFrontUrl: Uri.parseproductImage,
      ingredientsText: ingredients,
      lang: OpenFoodFactsLanguage.ENGLISH,
    );

    // a registered user login for https://world.openfoodfacts.org/ is required
    User myUser =
        User(userId: 'christian-tsoungui-nkoulou', password: 'Whatsupbro3');

    // query the OpenFoodFacts API
    Status result = await OpenFoodAPIClient.saveProduct(myUser, myProduct);

    if (result.status != 1) {
      throw Exception('product could not be added: ${result.error}');
    }
  }

  void veganCheck(BuildContext context) {
    sheVegan = true;
    nonVeganIngredientsInProduct = "";
    if (labels!.isEmpty) {
      print('isEmpty');
      ingredients!.forEach((ingredient) {
        print(ingredient.text);
        print(ingredient.vegan);
        if (ingredient.vegan == null ||
            ingredient.vegan == IngredientSpecialPropertyStatus.MAYBE) {
          nonVeganIngredients.forEach((nonVeganIngredient) {
            if (ingredient.text == nonVeganIngredient) {
              nonVeganIngredientsInProduct =
                  nonVeganIngredientsInProduct + "${ingredient.text!},  ";
              sheVegan = false;
            }
          });
        }
        if (ingredient.vegan == IngredientSpecialPropertyStatus.NEGATIVE) {
          nonVeganIngredientsInProduct =
              nonVeganIngredientsInProduct + "${ingredient.text!},  ";
          sheVegan = false;
        }
      });
    } else if (!(labels!.toLowerCase().contains('vegan') ||
        labels!.toLowerCase().contains('contains no animal ingredients'))) {
      ingredients!.forEach((ingredient) {
        print(ingredient.text);
        print(ingredient.vegan);
        if (ingredient.vegan == null ||
            ingredient.vegan == IngredientSpecialPropertyStatus.MAYBE) {
          nonVeganIngredients.forEach((nonVeganIngredient) {
            if (ingredient.text == nonVeganIngredient) {
              nonVeganIngredientsInProduct =
                  nonVeganIngredientsInProduct + "${ingredient.text!},  ";
              sheVegan = false;
            }
          });
        }
        if (ingredient.vegan == IngredientSpecialPropertyStatus.NEGATIVE) {
          nonVeganIngredientsInProduct =
              nonVeganIngredientsInProduct + "${ingredient.text!},  ";
          sheVegan = false;
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
        duration: Duration(seconds: 5),
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
