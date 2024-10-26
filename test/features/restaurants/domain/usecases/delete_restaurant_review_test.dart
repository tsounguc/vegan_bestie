import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/delete_restaurant_review.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late DeleteRestaurantReview useCase;
  final testReview = RestaurantReview.empty();

  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = DeleteRestaurantReview(repository);
    registerFallbackValue(testReview);
  });

  final testFailure = RestaurantsFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the DeleteRestaurantReview use case '
    'when instantiated '
    'then call [RestaurantsRepository.deleteRestaurantReview] '
    'and return [void]',
    () async {
      // Arrange
      when(
        () => repository.deleteRestaurantReview(
          restaurantReview: any(named: 'restaurantReview'),
        ),
      ).thenAnswer((_) async => const Right(null));
      // Act
      final result = await useCase(testReview);
      // Assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repository.deleteRestaurantReview(restaurantReview: testReview),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the DeleteRestaurantReview use case '
    'when instantiated '
    'and [RestaurantsRepository.deleteRestaurantReview] call unsuccessful '
    'then [RestaurantsFailure]',
    () async {
      // Arrange
      when(
        () => repository.deleteRestaurantReview(
          restaurantReview: any(named: 'restaurantReview'),
        ),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(testReview);
      // Assert
      expect(result, equals(Left<Failure, void>(testFailure)));
      verify(
        () => repository.deleteRestaurantReview(restaurantReview: testReview),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
