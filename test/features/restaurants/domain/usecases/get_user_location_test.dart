import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late GetUserLocation useCase;
  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = GetUserLocation(repository);
  });

  final testResponse = UserLocation.empty();
  const testFailure = UserLocationFailure(message: 'message', statusCode: 500);

  test(
    'given the GetUserLocation use case '
    'when instantiated '
    'then call [RestaurantsRepository.getUserLocation] '
    'and return [UserLocation]',
    () async {
      // Arrange
      when(
        () => repository.getUserLocation(),
      ).thenAnswer((_) async => Right(testResponse));
      // Act
      final result = await useCase();
      // Assert
      expect(result, Right<Failure, UserLocation>(testResponse));
      verify(
        () => repository.getUserLocation(),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given the GetRestaurantsNearMe use case '
    'when instantiated '
    'and call [RestaurantsRepository.getRestaurantsNearMe] is unsuccessful '
    'then return [UserLocationFailure]',
    () async {
      // Arrange
      when(
        () => repository.getUserLocation(),
      ).thenAnswer((_) async => const Left(testFailure));
      // Act
      final result = await useCase();
      // Assert
      expect(
        result,
        const Left<Failure, UserLocation>(testFailure),
      );
      verify(
        () => repository.getUserLocation(),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
