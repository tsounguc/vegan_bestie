import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/delete_restaurant_submission.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late DeleteRestaurantSubmission useCase;
  final testRestaurantSubmit = RestaurantSubmit.empty();

  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = DeleteRestaurantSubmission(repository);
    registerFallbackValue(testRestaurantSubmit);
  });

  final testFailure = RestaurantsFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the DeleteRestaurantSubmission use case '
    'when instantiated '
    'then call [RestaurantsRepository.deleteRestaurantSubmission] '
    'and return [void]',
    () async {
      // Arrange
      when(
        () => repository.deleteRestaurantSubmission(
          restaurantSubmit: any(named: 'restaurantSubmit'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );
      // Act
      final result = await useCase(testRestaurantSubmit);
      // Assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repository.deleteRestaurantSubmission(
          restaurantSubmit: testRestaurantSubmit,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the DeleteRestaurantSubmission use case '
    'when instantiated '
    'and [RestaurantsRepository.deleteRestaurantSubmission] called unsuccessfully '
    'then return [RestaurantsFailure]',
    () async {
      // Arrange
      when(
        () => repository.deleteRestaurantSubmission(
          restaurantSubmit: any(named: 'restaurantSubmit'),
        ),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(testRestaurantSubmit);
      // Assert
      expect(result, equals(Left<Failure, void>(testFailure)));
      verify(
        () => repository.deleteRestaurantSubmission(
          restaurantSubmit: testRestaurantSubmit,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
