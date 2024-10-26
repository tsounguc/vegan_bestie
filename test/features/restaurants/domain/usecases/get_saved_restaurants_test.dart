import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_saved_restaurants.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late GetSavedRestaurants useCase;
  const testRestaurant = Restaurant.empty();
  final testRestaurantsIdsList = [testRestaurant.id];

  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = GetSavedRestaurants(repository);
    registerFallbackValue(testRestaurant);
    registerFallbackValue(testRestaurantsIdsList);
  });

  final testFailure = RestaurantsFailure(
    message: 'message',
    statusCode: 500,
  );
  final testSavedRestaurants = [const Restaurant.empty()];

  test(
    'given the GetSavedRestaurants use case '
    'when instantiated '
    'then call [RestaurantsRepository.getSavedRestaurants] '
    'and return [void]',
    () async {
      // Arrange
      when(
        () => repository.getSavedRestaurants(
          restaurantsIdsList: any(named: 'restaurantsIdsList'),
        ),
      ).thenAnswer((_) async => Right(testSavedRestaurants));
      // Act
      final result = await useCase(testRestaurantsIdsList);
      // Assert
      expect(result, equals(Right<Failure, void>(testSavedRestaurants)));
      verify(
        () => repository.getSavedRestaurants(
          restaurantsIdsList: testRestaurantsIdsList,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the GetSavedRestaurants use case '
    'when instantiated '
    'and [RestaurantsRepository.getSavedRestaurants] called unsuccessfully '
    'then return [RestaurantsFailure]',
    () async {
      // Arrange
      when(
        () => repository.getSavedRestaurants(
          restaurantsIdsList: any(named: 'restaurantsIdsList'),
        ),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(testRestaurantsIdsList);
      // Assert
      expect(result, equals(Left<Failure, void>(testFailure)));
      verify(
        () => repository.getSavedRestaurants(
          restaurantsIdsList: testRestaurantsIdsList,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
