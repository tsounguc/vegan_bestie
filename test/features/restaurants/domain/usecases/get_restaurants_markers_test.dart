import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_markers.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late GetRestaurantsMarkers useCase;

  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = GetRestaurantsMarkers(repository);
  });

  final params = GetRestaurantsMarkersParams.empty();
  final testFailure = MapFailure(message: 'message', statusCode: 500);
  final testResponse = MapEntity.empty();

  test(
    'given the GetRestaurantsMarkers use case '
    'when instantiated '
    'then call [RestaurantsRepository.getRestaurantsMarkers] '
    'and return [MapEntity]',
    () async {
      // Arrange
      when(
        () => repository.getRestaurantsMarkers(restaurants: params.restaurants),
      ).thenAnswer((_) async => Right(testResponse));
      // Act
      final result = await useCase(params);
      // Assert
      expect(result, Right<Failure, MapEntity>(testResponse));
      verify(
        () => repository.getRestaurantsMarkers(
          restaurants: params.restaurants,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the GetRestaurantsMarkers use case '
    'when instantiated '
    'and call [RestaurantsRepository.getRestaurantsMarkers] is unsuccessful '
    'then return [MapFailure]',
    () async {
      // Arrange
      when(
        () => repository.getRestaurantsMarkers(restaurants: params.restaurants),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(params);
      // Assert
      expect(
        result,
        Left<Failure, MapEntity>(testFailure),
      );
      verify(
        () => repository.getRestaurantsMarkers(
          restaurants: params.restaurants,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
