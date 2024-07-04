import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_markers.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late GetRestaurantsMarkers useCase;
  final params = GetRestaurantsMarkersParams.empty();
  final testFailure = RestaurantsFailure(message: 'message', statusCode: 500);
  const testRestaurants = [Restaurant.empty()];
  final testResponse = MapEntity.empty();
  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = GetRestaurantsMarkers(repository);
    registerFallbackValue(testRestaurants);
  });

  test(
      'given the GetRestaurantMarkers use case '
      'when instantiated '
      'then call [RestaurantsRepository.getRestaurantsMarkers] '
      'and return [MapEntity]', () async {
    // Arrange
    when(
      () => repository.getRestaurantsMarkers(
        restaurants: any(named: 'restaurants'),
      ),
    ).thenAnswer((_) async => Right(testResponse));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Right<Failure, MapEntity>(testResponse));
    verify(
      () => repository.getRestaurantsMarkers(
        restaurants: any(named: 'restaurants'),
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      'given the GetRestaurantMarkers use case '
      'when instantiated '
      'then call [RestaurantsRepository.getRestaurantsMarkers] is unsuccessfull'
      'and return [RestaurantsFailure]', () async {
    // Arrange
    when(
      () => repository.getRestaurantsMarkers(
        restaurants: any(named: 'restaurants'),
      ),
    ).thenAnswer((_) async => Left(testFailure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, Left<Failure, MapEntity>(testFailure));
    verify(
      () => repository.getRestaurantsMarkers(
        restaurants: any(named: 'restaurants'),
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
