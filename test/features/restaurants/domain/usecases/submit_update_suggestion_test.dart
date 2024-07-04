import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/submit_update_suggestion.dart';

import 'restaurants_repository.mock.dart';

void main() {
  late RestaurantsRepository repository;
  late SubmitUpdateSuggestion useCase;
  const testRestaurant = Restaurant.empty();
  setUp(() {
    repository = MockRestaurantsRepository();
    useCase = SubmitUpdateSuggestion(repository);
    registerFallbackValue(testRestaurant);
  });

  final testFailure = RestaurantsFailure(
    message: 'message',
    statusCode: 500,
  );

  test(
    'given the SubmitUpdateSuggestion use case '
    'when instantiated '
    'then call [RestaurantsRepository.submitUpdateSuggestion] '
    'and return [void]',
    () async {
      // Arrange
      when(
        () => repository.submitUpdateSuggestion(restaurant: testRestaurant),
      ).thenAnswer((_) async => const Right(null));
      // Act
      final result = await useCase(testRestaurant);
      // Assert
      expect(result, equals(const Right<Failure, void>(null)));
      verify(
        () => repository.submitUpdateSuggestion(restaurant: testRestaurant),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
