import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_details.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late GetRestaurantDetails useCase;
  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = GetRestaurantDetails(repository);
  });
  final testResponse = RestaurantDetails.empty();
  const params = GetRestaurantDetailsParams.empty();
  const testFailure = RestaurantDetailsFailure(
    message: 'message',
    statusCode: 500,
  );
  test(
    'given the GetRestaurantDetails use case '
    'when instantiated '
    'then call [RestaurantsRepository.getRestaurantDetails] '
    'and return [RestaurantDetails]',
    () async {
      // Arrange
      when(
        () => repository.getRestaurantDetails(id: params.id),
      ).thenAnswer((_) async => Right(testResponse));
      // Act
      final result = await useCase(params);
      // Assert
      expect(result, Right<Failure, RestaurantDetails>(testResponse));
      verify(
        () => repository.getRestaurantDetails(id: params.id),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the GetRestaurantDetails use case '
    'when instantiated '
    'and call [RestaurantsRepository.getRestaurantDetails] is unsuccessful '
    'then return [RestaurantDetailsFailure]',
    () async {
      // Arrange
      when(
        () => repository.getRestaurantDetails(id: params.id),
      ).thenAnswer(
        (_) async => const Left(testFailure),
      );
      // Act
      final result = await useCase(params);
      // Assert
      expect(
        result,
        const Left<Failure, RestaurantDetails>(testFailure),
      );
      verify(
        () => repository.getRestaurantDetails(id: params.id),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
