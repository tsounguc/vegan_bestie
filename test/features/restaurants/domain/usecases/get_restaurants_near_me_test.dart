import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late GetRestaurantsNearMe useCase;
  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = GetRestaurantsNearMe(repository);
  });
  final params = GetRestaurantsNearMeParams.empty();
  final testFailure = RestaurantsFailure(message: 'message', statusCode: 500);
  const testResponse = [Restaurant.empty()];

  test(
    'given the GetRestaurantsNearMe use case '
    'when instantiated '
    'then call [RestaurantsRepository.getRestaurantsNearMe] '
    'and return [List<Restaurant>]',
    () async {
      // Arrange
      when(
        () => repository.getRestaurantsNearMe(
          position: params.position,
          radius: params.radius,
        ),
      ).thenAnswer((_) async => const Right(testResponse));
      // Act
      final result = await useCase(params);
      // Assert
      expect(result, const Right<Failure, List<Restaurant>>(testResponse));
      verify(
        () => repository.getRestaurantsNearMe(
          position: params.position,
          radius: params.radius,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the GetRestaurantsNearMe use case '
    'when instantiated '
    'and call [RestaurantsRepository.getRestaurantsNearMe] is unsuccessful '
    'then return [RestaurantsFailure]',
    () async {
      // Arrange
      when(
        () => repository.getRestaurantsNearMe(position: params.position, radius: params.radius),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(params);
      // Assert
      expect(
        result,
        Left<Failure, List<Restaurant>>(testFailure),
      );
      verify(
        () => repository.getRestaurantsNearMe(
          position: params.position,
          radius: params.radius,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
