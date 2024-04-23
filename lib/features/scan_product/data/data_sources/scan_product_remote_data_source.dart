import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/restaurants_services/barcode_scanner_plugin.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/services/vegan_checker.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/scan_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/scan_product/data/models/food_product_model.dart';

abstract class ScanProductRemoteDataSource {
  Future<BarcodeModel> scanBarcode();

  Future<FoodProductModel> fetchProduct({required String barcode});

  Future<void> saveFoodProduct({
    required String barcode,
  });

  Future<void> removeFoodProduct({
    required String barcode,
  });

  Future<List<FoodProductModel>> fetchSavedProductsList({
    required List<String> barcodesList,
  });
}

const kFetchProductEndPoint = '/api/v2/product/';

class ScanProductRemoteDataSourceImpl implements ScanProductRemoteDataSource {
  const ScanProductRemoteDataSourceImpl(
    this._scanner,
    this._client,
    this._cloudStoreClient,
    this._authClient,
    this._veganChecker,
  );

  final BarcodeScannerPlugin _scanner;
  final Client _client;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseAuth _authClient;
  final VeganChecker _veganChecker;

  @override
  Future<FoodProductModel> fetchProduct({required String barcode}) async {
    try {
      final response = await _client.get(
        Uri.parse('$kFoodFactBaseUrl$kFetchProductEndPoint$barcode'),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw FetchProductException(
          message: Strings.productNotFound,
          statusCode: response.statusCode,
        );
      }

      final data = jsonDecode(response.body);

      var foodProduct = FoodProductModel.fromMap(data['product'] as DataMap);
      final isVegan = _veganChecker.veganCheck(foodProduct);
      final isVegetarian = _veganChecker.vegetarianCheck(foodProduct);
      return foodProduct = foodProduct.copyWith(
        isVegan: isVegan,
        isVegetarian: !isVegan && isVegetarian,
        nonVeganIngredients: isVegetarian
            ? serviceLocator<VeganChecker>().nonVeganIngredientsInProduct
            : serviceLocator<VeganChecker>().nonVegetarianIngredientsInProduct,
      );
    } on FetchProductException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw FetchProductException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<BarcodeModel> scanBarcode() async {
    try {
      final result = await _scanner.scanBarcode();
      final barcode = BarcodeModel(barcode: result);
      return barcode;
    } on ScanException catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw ScanException(message: e.toString(), statusCode: 502);
    }
  }

  @override
  Future<void> saveFoodProduct({required String barcode}) async {
    try {
      await _users.doc(_authClient.currentUser?.uid).update({
        'savedProductsBarcodes': FieldValue.arrayUnion([barcode]),
      });
    } on FirebaseException catch (e) {
      throw UpdateUserDataException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw UpdateUserDataException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> removeFoodProduct({required String barcode}) async {
    try {
      await _users.doc(_authClient.currentUser?.uid).update({
        'savedProductsBarcodes': FieldValue.arrayRemove([barcode]),
      });
    } on FirebaseException catch (e) {
      throw SaveFoodProductException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw SaveFoodProductException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<List<FoodProductModel>> fetchSavedProductsList({
    required List<String> barcodesList,
  }) async {
    final productsList = <FoodProductModel>[];
    for (final barcode in barcodesList) {
      final product = await fetchProduct(barcode: barcode);
      productsList.add(product);
    }

    return productsList;
  }

  CollectionReference<Map<String, dynamic>> get _users => _cloudStoreClient.collection(
        FirebaseConstants.usersCollection,
      );
}
