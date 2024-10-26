import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/unsave_restaurant.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late UnSaveRestaurant useCase;
  const testRestaurant = Restaurant.empty();
  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = UnSaveRestaurant(repository);
    registerFallbackValue(testRestaurant);
  });

  final testFailure = RestaurantsFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the UnSaveRestaurant use case '
    'when instantiated '
    'then call [RestaurantsRepository.unSaveRestaurant] '
    'and return [void]',
    () async {
      // Arrange
      when(
        () => repository.unSaveRestaurant(
          restaurantId: any(named: 'restaurantId'),
        ),
      ).thenAnswer((_) async => const Right(null));
      // Act
      final result = await useCase(testRestaurant.id);
      // Assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repository.unSaveRestaurant(restaurantId: testRestaurant.id),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the UnSaveRestaurant use case '
    'when instantiated '
    'and [RestaurantsRepository.unSaveRestaurant] called unsuccessfully '
    'then return [RestaurantsFailure]',
    () async {
      // Arrange
      when(
        () => repository.unSaveRestaurant(
          restaurantId: any(named: 'restaurantId'),
        ),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(testRestaurant.id);
      // Assert
      expect(result, equals(Left<Failure, void>(testFailure)));
      verify(
        () => repository.unSaveRestaurant(restaurantId: testRestaurant.id),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
