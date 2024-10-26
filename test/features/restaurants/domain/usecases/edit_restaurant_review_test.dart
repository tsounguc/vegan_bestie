import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/edit_restaurant_review.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late EditRestaurantReview useCase;
  final testReview = RestaurantReview.empty();
  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = EditRestaurantReview(repository);
    registerFallbackValue(testReview);
  });

  final testFailure = RestaurantsFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the EditRestaurantReview use case '
    'when instantiated '
    'then call [RestaurantsRepository.editRestaurantReview] '
    'and return [void]',
    () async {
      // Arrange
      when(() => repository.editRestaurantReview(restaurantReview: any(named: 'restaurantReview'))).thenAnswer(
        (_) async => const Right(null),
      );
      // Act
      final result = await useCase(testReview);
      // Assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repository.editRestaurantReview(restaurantReview: testReview),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the EditRestaurantReview use case '
    'when instantiated '
    'and [RestaurantsRepository.editRestaurantReview] call unsuccessful '
    'then return [RestaurantsFailure]',
    () async {
      // Arrange
      when(
        () => repository.editRestaurantReview(
          restaurantReview: any(named: 'restaurantReview'),
        ),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(testReview);
      // Assert
      expect(result, equals(Left<Failure, void>(testFailure)));
      verify(
        () => repository.editRestaurantReview(restaurantReview: testReview),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
