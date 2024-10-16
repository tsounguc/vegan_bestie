import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testJson = fixture('restaurant.json');
  final testRestaurantModel = RestaurantModel.fromJson(testJson);
  final testMap = testRestaurantModel.toMap();

  test(
    'given [RestaurantModel], '
    'when instantiated '
    'then instance should be a subclass of [Restaurant] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testRestaurantModel, isA<Restaurant>());
    },
  );

  group('copy - ', () {
    const testRestaurant = Restaurant(
      id: '12345678',
      name: 'name',
      nameLowercase: 'nameLowercase',
      contactName: 'contactName',
      email: 'email',
      streetAddress: 'streetAddress',
      city: 'city',
      state: 'state',
      zipCode: 'zipCode',
      county: 'county',
      areaCode: 'areaCode',
      phoneNumber: 'phoneNumber',
      websiteUrl: 'websiteUrl',
      geoLocation: GeoLocation.empty(),
      openHours: OpenHours.empty(),
      photos: [],
      price: 'price',
      veganStatus: false,
      hasVeganOptions: false,
      dineIn: false,
      takeout: false,
      delivery: false,
      permanentlyClosed: false,
    );
    test(
      'given [RestaurantModel], '
      'when copy constructor called, '
      'then return [RestaurantModel] with updated data from [Restaurant]',
      () {
        // Arrange
        // Act
        final result = RestaurantModel.copy(testRestaurant);
        // Assert
        expect(result.id, equals(testRestaurant.id));
      },
    );
  });

  group('fromMap - ', () {
    test(
        'given [RestaurantModel], '
        'when fromMap is called, '
        'then return [RestaurantModel] with correct data ', () {
      // Arrange
      // Act
      final result = RestaurantModel.fromMap(testMap);
      // Assert
      expect(result, equals(testRestaurantModel));
    });
  });

  group('fromJson - ', () {
    test(
        'given [RestaurantModel], '
        'when fromJson is called, '
        'then return [RestaurantModel] with correct data ', () {
      // Arrange
      // Act
      final result = RestaurantModel.fromJson(testJson);
      // Assert
      expect(result, equals(testRestaurantModel));
    });
  });

  group('toMap - ', () {
    test(
        'given [RestaurantModel], '
        'when toMap is called, '
        'then return [Map] with correct data ', () {
      // Arrange
      // Act
      final result = testRestaurantModel.toMap();
      // Assert
      expect(result, equals(testMap));
    });
  });

  group('toJson - ', () {
    test(
        'given [RestaurantModel], '
        'when toJson is called, '
        'then return [JSON] with correct data ', () {
      // Arrange
      // Act
      final result = testRestaurantModel.toJson();
      // Assert
      expect(
        result,
        equals(
          jsonEncode(testMap),
        ),
      );
    });
  });

  group('copyWith - ', () {
    test(
        'given [RestaurantModel], '
        'when copyWith is called, '
        'then return [RestaurantModel] with updated data ', () {
      // Arrange
      // Act
      final result = testRestaurantModel.copyWith(id: '12345678');
      // Assert
      expect(result.id, equals('12345678'));
    });
  });
}
