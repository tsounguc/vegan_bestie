import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/enums/update_restaurant_info.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/update_restaurant.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late UpdateRestaurant useCase;
  const testRestaurant = Restaurant.empty();
  const testAction = UpdateRestaurantInfoAction.name;

  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = UpdateRestaurant(repository);
    registerFallbackValue(testRestaurant);
    registerFallbackValue(testAction);
  });

  const params = UpdateRestaurantParams.empty();

  final testFailure = RestaurantsFailure(message: 'message', statusCode: 500);

  test(
    'given UpdateRestaurant useCase '
    'when instantiated '
    'then [RestaurantsRepository.updateRestaurant] should be called '
    'and return [void] ',
    () async {
      // Arrange
      when(
        () => repository.updateRestaurant(
          restaurant: any(named: 'restaurant'),
          restaurantData: 'empty.name',
          action: any(named: 'action'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );
      // Act
      final result = await useCase(params);
      // Assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repository.updateRestaurant(
          restaurant: params.restaurant,
          restaurantData: params.restaurantData,
          action: params.action,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given UpdateRestaurant useCase '
    'when instantiated '
    'then [RestaurantsRepository.updateRestaurant] call unsuccessfully '
    'and return [RestaurantFailure] ',
    () async {
      // Arrange
      when(
        () => repository.updateRestaurant(
          restaurant: any(named: 'restaurant'),
          restaurantData: 'empty.name',
          action: any(named: 'action'),
        ),
      ).thenAnswer((_) async => Left(testFailure));
      // Act
      final result = await useCase(params);
      // Assert
      expect(result, equals(Left<Failure, void>(testFailure)));
      verify(
        () => repository.updateRestaurant(
          restaurant: params.restaurant,
          restaurantData: params.restaurantData,
          action: params.action,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
