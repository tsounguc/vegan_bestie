import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/submit_restaurant.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late SubmitRestaurant useCase;
  final testRestaurantSubmit = RestaurantSubmit.empty();

  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = SubmitRestaurant(repository);
    registerFallbackValue(testRestaurantSubmit);
  });

  final testFailure = RestaurantsFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the SubmitRestaurant use case '
    'when instantiated '
    'then call [RestaurantsRepository.submitRestaurant] '
    'and return [void] ',
    () async {
      // Arrange
      when(
        () => repository.submitRestaurant(
          restaurantSubmit: any(named: 'restaurantSubmit'),
        ),
      ).thenAnswer((_) async => const Right(null));
      // Act
      final result = await useCase(testRestaurantSubmit);
      // Assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repository.submitRestaurant(
          restaurantSubmit: testRestaurantSubmit,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the SubmitRestaurant use case '
    'when instantiated '
    'and [RestaurantsRepository.submitRestaurant] called unsuccessfully '
    'and return [RestaurantFailure] ',
    () async {
      // Arrange
      when(
        () => repository.submitRestaurant(
          restaurantSubmit: any(named: 'restaurantSubmit'),
        ),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(testRestaurantSubmit);
      // Assert
      expect(result, equals(Left<Failure, void>(testFailure)));
      verify(
        () => repository.submitRestaurant(
          restaurantSubmit: testRestaurantSubmit,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
