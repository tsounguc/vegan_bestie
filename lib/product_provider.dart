import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/product_info.dart';

class ProductStateNotifier extends StateNotifier<ProductInfo> {
  ProductStateNotifier() : super(ProductInfo());

  final ImagePicker picker = ImagePicker();
  final textDetector = GoogleMlKit.vision.textDetector();

  String? error;
  String? imageUrl;
  PickedFile? imageToUpload;
  File? croppedImage;
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

  Future onBarcodeButtonPressed(BuildContext context) async {
    try {
      barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Cancel', true, ScanMode.BARCODE);
      // barcode = "016000277076";
      // barcode = "848860002099";
      // barcode = "4099100018677";
      // barcode = "052000047776";
      print("Barcode: " + barcode!);

      if (barcode!.isNotEmpty) {
        print("barcode not empty");
        state = ProductInfo(loading: true);
        Product? product = await getProduct(context);
        initState(product!);
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
    state = ProductInfo();

    labels = "";
    if (product.productName == null) {
      productName = '';
      error = 'This product is missing is missing a name';
    } else {
      productName = product.productName;
    }

    if (product.ingredients == null ||
        product.ingredientsText == null ||
        product.ingredients!.length <= 0 ||
        product.ingredientsText!.isEmpty) {
      ingredients = [];
      ingredientsText = "";
      if (product.productName == null) {
        error = 'This product is missing a name and ingredients list';
      } else {
        error = '${product.productName} is missing ingredients list';
      }
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
        if (error!.contains('no code or invalid code')) {
          barcode = "";
          productName = "";
        }
        state = state
          ..barcode = barcode
          ..productName = productName
          ..error = error
          ..loading = false;

        throw Exception('Error retrieving the product: ' + error!);
      }
      print("product found: ${result.product!.productName}");

      return result.product;
    } on Exception catch (e) {
      print(e);
      // final snackBar = SnackBar(
      //   // duration: Duration(seconds: 5),
      //   backgroundColor: Colors.amber,
      //   content: Text(error!),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void addNewProduct(
      String barcode, String productName, String ingredients) async {
    // a registered user login for https://world.openfoodfacts.org/ is required
    User myUser =
        User(userId: 'christian-tsoungui-nkoulou', password: 'Whatsupbro3');

    if (barcode.isNotEmpty &&
        productName.isNotEmpty &&
        ingredients.isNotEmpty) {
      // define the product to be added.
      // more attributes available ...
      Product myProduct = Product(
        barcode: barcode,
        productName: productName,
        // imageFrontUrl: Uri.parseproductImage,
        ingredientsText: ingredients,
        lang: OpenFoodFactsLanguage.ENGLISH,
      );
      // query the OpenFoodFacts API
      Status result = await OpenFoodAPIClient.saveProduct(myUser, myProduct);

      if (result.status != 1) {
        //TODO: Let user know in the UI that product could not be added
        throw Exception('product could not be added: ${result.error}');
      }
    }

    if (croppedImage != null && croppedImage!.path.isNotEmpty) {
      SendImage image = SendImage(
        lang: OpenFoodFactsLanguage.ENGLISH,
        barcode: barcode,
        imageUri: Uri.parse(croppedImage!.path),
        imageField: ImageField.FRONT,
      );
      Status sendImageResult =
          await OpenFoodAPIClient.addProductImage(myUser, image);
      if (sendImageResult.status != 'status ok') {
        throw Exception(
            'image could not be uploated: ${sendImageResult.error} ${sendImageResult.imageId.toString()}');
      }
    }
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: [
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: Text("Camera"),
                  onTap: () {
                    getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: Text("Photo Library"),
                  onTap: () {
                    getImage(ImageSource.gallery);
                    // _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getImage(ImageSource source) async {
    state = state..loading = true;
    imageToUpload = null;
    croppedImage = null;
    imageToUpload = await picker.getImage(source: source);

    if (imageToUpload != null) {
      croppedImage = await ImageCropper.cropImage(
        sourcePath: imageToUpload!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        compressFormat: ImageCompressFormat.jpg,
        maxHeight: 700,
        maxWidth: 700,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: gradientStartColor,
          toolbarTitle: "Crop Image",
          statusBarColor: gradientStartColor,
          backgroundColor: Colors.white,
        ),
      );
      print(croppedImage!.path);
      state = state
        ..imageToUpLoadPath = croppedImage!.path
        ..loading = false;
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
            if (ingredient.text!.toLowerCase() ==
                nonVeganIngredient.toLowerCase()) {
              nonVeganIngredientsInProduct = nonVeganIngredientsInProduct +
                  "${ingredient.text!.toLowerCase()},  ";
              sheVegan = false;
            }
          });
        }
        if (ingredient.vegan == IngredientSpecialPropertyStatus.NEGATIVE) {
          nonVeganIngredientsInProduct = nonVeganIngredientsInProduct +
              "${ingredient.text!.toLowerCase()},  ";
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
            if (ingredient.text!.toLowerCase() ==
                nonVeganIngredient.toLowerCase()) {
              nonVeganIngredientsInProduct = nonVeganIngredientsInProduct +
                  "${ingredient.text!.toLowerCase()},  ";
              sheVegan = false;
            }
          });
        }
        if (ingredient.vegan == IngredientSpecialPropertyStatus.NEGATIVE) {
          nonVeganIngredientsInProduct = nonVeganIngredientsInProduct +
              "${ingredient.text!.toLowerCase()},  ";
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

  void readProductNameFromImage() async {
    PickedFile? picture = await picker.getImage(source: ImageSource.camera);
    //Use text recognition plugin to get text out of picture
    File? croppedPicture = await ImageCropper.cropImage(
      sourcePath: picture!.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      maxHeight: 700,
      maxWidth: 700,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: gradientStartColor,
        toolbarTitle: "Crop Image",
        statusBarColor: gradientStartColor,
        backgroundColor: Colors.white,
      ),
    );

    InputImage inputImage = InputImage.fromFilePath(croppedPicture!.path);
    RecognisedText recognisedText = await textDetector.processImage(inputImage);

    //Set productName to recognized text
    String formattedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        formattedText = formattedText + " " + line.text;
      }
    }
    productName = formattedText;
    print(productName);

    //Set state
    state = state..productName = productName;
  }

  void readIngredientsFromImage() async {
    //Take picture from imagePicker
    PickedFile? picture = await picker.getImage(source: ImageSource.camera);
    //Use text recognition plugin to get text out of picture
    File? croppedPicture = await ImageCropper.cropImage(
      sourcePath: picture!.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      maxHeight: 700,
      maxWidth: 700,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: gradientStartColor,
        toolbarTitle: "Crop Image",
        statusBarColor: gradientStartColor,
        backgroundColor: Colors.white,
      ),
    );

    InputImage inputImage = InputImage.fromFilePath(croppedPicture!.path);
    RecognisedText recognisedText = await textDetector.processImage(inputImage);

    //Set IngredientText to recognized text

    String formattedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        formattedText = formattedText + " " + line.text;
      }
    }

    ingredientsText = formattedText;
    print(ingredientsText);

    //Set state
    state = state..ingredients = ingredientsText;
  }

  void setIngredients(String? value) {
    print("set Ingredients: $value");
    ingredientsText = value;
    state = state..ingredients = value;
  }
}

final productProvider = StateNotifierProvider<ProductStateNotifier>(
    (ref) => new ProductStateNotifier());
