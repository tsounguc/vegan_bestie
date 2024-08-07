import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart';
import 'package:sheveegan/core/enums/update_food_product.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/restaurants_services/barcode_scanner_plugin.dart';
import 'package:sheveegan/core/services/vegan_checker.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/core/utils/datasource_utils.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/food_product/data/models/barcode_model.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_model.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_report_model.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';

abstract class FoodProductRemoteDataSource {
  Future<BarcodeModel> scanBarcode();

  Future<FoodProductModel> fetchProduct({required String barcode});

  Future<void> addFoodProduct({
    required FoodProduct foodProduct,
    required File productImage,
  });

  Future<void> saveFoodProduct({
    required String barcode,
  });

  Future<void> unSaveFoodProduct({
    required String barcode,
  });

  Future<List<FoodProductModel>> fetchSavedProductsList({
    required List<String> barcodesList,
  });

  Future<String> readIngredientsFromImage({required File image});

  Future<void> updateFoodProduct({
    required UpdateFoodAction action,
    required dynamic foodData,
    required FoodProduct foodProduct,
  });

  Future<void> reportIssue(FoodProductReport report);

  Future<List<FoodProductReportModel>> fetchFoodProductReports();

  Future<void> deleteReport(FoodProductReport report);
}

const kFetchFoodProductEndPoint = '/api/v2/product/';
const kAddFoodProductEndPoint = '/cgi/product_jqm2.pl?';

class FoodProductRemoteDataSourceImpl implements FoodProductRemoteDataSource {
  const FoodProductRemoteDataSourceImpl(
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
      final url = '$kFoodFactBaseUrl$kFetchFoodProductEndPoint$barcode';
      final parsedUri = Uri.parse(url);

      // final request = Request('GET', parsedUri);
      //
      // final streamResponse = await request.send();

      final response = await _client.get(parsedUri);

      if (response.statusCode != 200 && response.statusCode != 201) {
        debugPrint('${response.statusCode}');
        throw FetchProductException(
          message: Strings.productNotFound,
          statusCode: response.statusCode,
        );
      }

      final data = jsonDecode(response.body);

      final foodProduct = FoodProductModel.fromMap(data['product'] as DataMap);
      // debugPrint(foodProduct.id);
      final isVegan = _veganChecker.veganCheck(foodProduct);
      var isVegetarian = false;
      if (!isVegan) isVegetarian = _veganChecker.vegetarianCheck(foodProduct);
      var nonVeganIngredients = _veganChecker.nonVeganIngredientsInProduct;
      // TODO: remove last comma
      return foodProduct.copyWith(
        isVegan: isVegan,
        isVegetarian: isVegetarian,
        nonVeganIngredients: !isVegan && isVegetarian ? nonVeganIngredients : nonVeganIngredients,
      );
    } on FetchProductException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw const FetchProductException(message: 'Issue fetching product', statusCode: 500);
    }
  }

  @override
  Future<void> addFoodProduct({
    required FoodProduct foodProduct,
    required File productImage,
  }) async {
    try {
      final userId = dotenv.env['OpenFoodFactUserId'];
      debugPrint(userId);
      final password = dotenv.env['OpenFoodFactPassword'];
      debugPrint(password);

      final headers = {'user_id': userId!, 'password': password!};

      var infoUrl = '$kFoodFactBaseUrl$kAddFoodProductEndPoint'
          'code=${foodProduct.code}&user_id=$userId&password=$password';
      final queryComponent = '&product_name=${foodProduct.productName}'
              '&ingredients_text=${foodProduct.ingredientsText}'
              '&nutrition_data_per=100g'
              '&nutriment_proteins=${foodProduct.nutriments.proteins100G}'
              '&nutriment_carbohydrates=${foodProduct.nutriments.carbohydrates100G}'
              '&nutriment_fats=${foodProduct.nutriments.fat100G}'
          .replaceAll(',', '%2C')
          .replaceAll(' ', '%20')
          .replaceAll('(', '%28')
          .replaceAll(')', '%29')
          .replaceAll('.', '%2E')
          .replaceAll('and/or', '')
          .replaceAll('and', '');
      infoUrl += queryComponent;

      final infoRequest = Request('GET', Uri.parse(infoUrl));
      infoRequest.headers.addAll(headers);
      final infoStreamResponse = await infoRequest.send();

      final infoResponse = await Response.fromStream(infoStreamResponse);

      final infoResponseData = jsonDecode(infoResponse.body) as DataMap;

      if (infoResponseData['status'] == 0) {
        debugPrint(
          '${infoResponseData['status']}: ${infoResponseData['status_verbose']}',
        );

        throw UpdateFoodProductException(
          message: infoResponseData['status_verbose'].toString(),
          statusCode: infoResponseData['status'] as int,
        );
      } else {
        debugPrint(
          'Product Info Request Successful: '
          '${infoResponseData['status']}: ${infoResponseData['status_verbose']}',
        );

        final imageUrl = '$kFoodFactBaseUrl/cgi/product_image_upload.pl'
            'code=${foodProduct.code}&user_id=$userId&password=$password';

        final imageRequest = MultipartRequest('POST', Uri.parse(imageUrl))
          ..headers.addAll({
            'Content-Type': 'multipart/form-data',
            'user_id': userId,
            'password': password,
          })
          ..fields.addAll({
            'code': foodProduct.code,
            'imagefield': 'front',
          })
          ..files.add(
            await MultipartFile.fromPath(
              'imgupload_front',
              productImage.path,
            ),
          );
        final imageStreamResponse = await imageRequest.send();

        final imageResponse = await Response.fromStream(imageStreamResponse);

        final data = jsonDecode(imageResponse.body) as DataMap;

        if (data['status'] == 0) {
          debugPrint('${data['status']}: ${data['status_verbose']}');
          throw UpdateFoodProductException(
            message: data['status_verbose'].toString(),
            statusCode: data['status'] as int,
          );
        } else {
          debugPrint('Product Image Request Successful: '
              '${data['status']}: ${data['status_verbose']}');
        }
      }
    } on AddFoodProductException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw AddFoodProductException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> updateFoodProduct({
    required UpdateFoodAction action,
    required dynamic foodData,
    required FoodProduct foodProduct,
  }) async {
    try {
      final userId = dotenv.env['OpenFoodFactUserId'];
      debugPrint(userId);
      final password = dotenv.env['OpenFoodFactPassword'];
      debugPrint(password);
      var queryComponent = '';

      switch (action) {
        case UpdateFoodAction.imageFrontUrl:
          await updateFoodProductInfo(
            requestMethod: 'POST',
            endPoint: '/cgi/product_image_upload.pl',
            queryComponent: queryComponent,
            barcode: foodProduct.code,
            userId: userId ?? '',
            password: password ?? '',
            action: action,
            file: foodData as File,
            fileName: foodProduct.productName.toLowerCase().replaceAll(' ', ''),
          );
        case UpdateFoodAction.productName:
          queryComponent += '&product_name=$foodData'
              .replaceAll(',', '%2C')
              .replaceAll(' ', '%20')
              .replaceAll('(', '%28')
              .replaceAll(')', '%29')
              .replaceAll('.', '%2E')
              .replaceAll('and/or', '')
              .replaceAll('and', '');
          debugPrint(queryComponent);
          await updateFoodProductInfo(
            requestMethod: 'GET',
            endPoint: kAddFoodProductEndPoint,
            queryComponent: queryComponent,
            barcode: foodProduct.code,
            userId: userId ?? '',
            password: password ?? '',
            action: action,
          );
        case UpdateFoodAction.ingredients:
          debugPrint('$foodData');
          queryComponent += '&ingredients_text=$foodData'
              .replaceAll(',', '%2C')
              .replaceAll(' ', '%20')
              .replaceAll('(', '%28')
              .replaceAll(')', '%29')
              .replaceAll('.', '%2E')
              .replaceAll('and/or', '')
              .replaceAll('and', '');
          debugPrint(queryComponent);
          await updateFoodProductInfo(
            requestMethod: 'GET',
            endPoint: kAddFoodProductEndPoint,
            queryComponent: queryComponent,
            barcode: foodProduct.code,
            userId: userId ?? '',
            password: password ?? '',
            action: action,
          );
        case UpdateFoodAction.nutriments:
          final nutriments = foodData as Nutriments;
          queryComponent += '&nutrition_data_per=serving'
              '&nutriment_proteins=${nutriments.proteinsServing}'
              '&nutriment_carbohydrates=${nutriments.carbohydratesServing}'
              '&nutriment_fat=${nutriments.fatServing}';
          debugPrint(queryComponent);
          await updateFoodProductInfo(
            requestMethod: 'GET',
            endPoint: kAddFoodProductEndPoint,
            queryComponent: queryComponent,
            barcode: foodProduct.code,
            userId: userId ?? '',
            password: password ?? '',
            action: action,
          );
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
      throw const UpdateFoodProductException(
        message: 'Error: Connection Failed try again',
        statusCode: 500,
      );
    } on UpdateFoodProductException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint(e.toString());
      rethrow;
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint(e.toString());
      throw UpdateFoodProductException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  Future<void> updateFoodProductInfo({
    required String requestMethod,
    required String endPoint,
    required String queryComponent,
    required String barcode,
    required String userId,
    required String password,
    required UpdateFoodAction action,
    File? file,
    String? fileName,
  }) async {
    // debugPrint(queryComponent);
    final headers = {'user_id': userId, 'password': password};
    var url = '$kFoodFactBaseUrl$endPoint';
    if (action != UpdateFoodAction.imageFrontUrl) {
      url += 'code=$barcode&user_id=$userId&password=$password';
    }

    url += queryComponent;
    debugPrint('url: $url');
    final parsedUri = Uri.parse(url);
    late BaseRequest request;
    if (action == UpdateFoodAction.imageFrontUrl) {
      request = MultipartRequest(requestMethod, parsedUri)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
          'user_id': userId,
          'password': password,
        })
        ..fields.addAll({
          'code': barcode,
          'imagefield': 'front',
          // 'imgupload_front': '@${jsonEncode(file)}.jpg',
        })
        ..files.add(
          await MultipartFile.fromPath(
            'imgupload_front',
            file!.path,
          ),
        );

      final streamResponse = await request.send();

      final response = await Response.fromStream(streamResponse);
      final data = jsonDecode(response.body) as DataMap;
      if (data['status'] == 0) {
        debugPrint('${data['status']}: ${data['status_verbose']}');
        throw UpdateFoodProductException(
          message: data['status_verbose'].toString(),
          statusCode: data['status'] as int,
        );
      } else {
        debugPrint('${data['status']}: ${data['status_verbose']}');
      }
    } else {
      request = Request(requestMethod, parsedUri);
      request.headers.addAll(headers);
      final streamResponse = await request.send();

      final response = await Response.fromStream(streamResponse);
      final data = jsonDecode(response.body) as DataMap;
      if (data['status'] == 0) {
        debugPrint('${data['status']}: ${data['status_verbose']}');
        throw UpdateFoodProductException(
          message: data['status_verbose'].toString(),
          statusCode: data['status'] as int,
        );
      } else {
        debugPrint('${data['status']}: ${data['status_verbose']}');
      }
    }
    // request.headers.addAll(headers);
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
  Future<void> unSaveFoodProduct({required String barcode}) async {
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

  @override
  Future<List<FoodProductReportModel>> fetchFoodProductReports() async {
    final reports = <FoodProductReportModel>[];
    await _foodProductReport.get().then((snapshot) {
      debugPrint('${snapshot.docs.length}');
      final reportsData = snapshot.docs.map((doc) => doc.data());
      for (final reportData in reportsData) {
        final report = FoodProductReportModel.fromMap(
          reportData,
        );
        reports.add(report);
      }
    });

    return reports;
  }

  @override
  Future<void> deleteReport(FoodProductReport report) async {
    try {
      DataSourceUtils.authorizeUser(_authClient);

      return _foodProductReport.doc(report.id).delete();
    } on FirebaseException catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    } on DeleteReportException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  @override
  Future<String> readIngredientsFromImage({required File image}) async {
    try {
      var ingredients = '';
      final textRecognizer = TextRecognizer();
      final recognizedText = await textRecognizer.processImage(
        InputImage.fromFile(
          image,
        ),
      );
      var text = recognizedText.text.toLowerCase();
      if (text.contains('ingredients')) {
        final index = text.indexOf('ingredients:') + 'ngredients: '.length;
        text = text.replaceAll('\n', ' ').substring(index).trim();
        ingredients = text.capitalizeEveryWord(', ').capitalizeEveryWord(' (');
      }

      await textRecognizer.close();
      return ingredients;
    } on ReadIngredientsFromImageException catch (e, s) {
      debugPrintStack(stackTrace: s);
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ReadIngredientsFromImageException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> reportIssue(FoodProductReport report) async {
    try {
      final reportReference = _foodProductReport.doc();

      final reportModel = (report as FoodProductReportModel).copyWith(id: reportReference.id);

      await reportReference.set(
        reportModel.toMap(),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  CollectionReference<Map<String, dynamic>> get _users => _cloudStoreClient.collection(
        FirebaseConstants.usersCollection,
      );

  CollectionReference<Map<String, dynamic>> get _foodProductReport => _cloudStoreClient.collection(
        FirebaseConstants.foodProductReportCollection,
      );
}
