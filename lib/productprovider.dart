import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:sheveegan/product.dart';

class ProductStateNotifier extends StateNotifier<ProductInfo> {
  ProductStateNotifier() : super(ProductInfo());

  String? error;
  String? imageUrl;
  String? barcode;
  String? productName;
  String? ingredients;
  String? labels;

  Future scan(BuildContext context) async {
    try {
      barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Cancel', true, ScanMode.BARCODE);
      print("Barcode: " + barcode!);
      if (barcode!.isNotEmpty) {
        Product? product = await getProduct(context);
        error = "";
        productName = product!.productName;
        ingredients = product.ingredientsText;
        labels = product.labels;
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
        }
        state = ProductInfo(
          barcode: barcode,
          productName: productName,
          ingredients: ingredients,
          labels: labels,
          imageUrl: imageUrl,
          error: error,
        );
      }
    } on PlatformException catch (e) {
      print("PlatformException: $e");
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
      final snackBar = SnackBar(backgroundColor: Colors.amber,
        content: Text(error!),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);}
    }
  }

  final productProvider = StateNotifierProvider<ProductStateNotifier>(
          (ref) => new ProductStateNotifier());
