import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/add_restaurant.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late AddRestaurant useCase;
  const testRestaurant = Restaurant.empty();
  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = AddRestaurant(repository);
    registerFallbackValue(testRestaurant);
  });

  final testFailure = RestaurantsFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the AddRestaurant use case '
    'when instantiated '
    'then call [RestaurantsRepository.addRestaurant] '
    'and return [void]',
    () async {
      // Arrange
      when(
        () => repository.addRestaurant(restaurant: testRestaurant),
      ).thenAnswer((_) async => const Right(null));
      // Act
      final result = await useCase(testRestaurant);
      // Assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repository.addRestaurant(restaurant: testRestaurant),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
