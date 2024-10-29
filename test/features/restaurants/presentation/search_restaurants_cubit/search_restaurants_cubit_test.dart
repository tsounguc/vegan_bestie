import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/search_restaurants.dart';
import 'package:sheveegan/features/restaurants/presentation/search_restaurants_cubit/search_restaurants_cubit.dart';

class MockSearchRestaurants extends Mock implements SearchRestaurants {}

void main() {
  late SearchRestaurants searchRestaurants;
  late SearchRestaurantsCubit cubit;
  late String testQuery;

  late RestaurantsFailure testFailure;

  setUp(() {
    searchRestaurants = MockSearchRestaurants();
    cubit = SearchRestaurantsCubit(
      searchRestaurants: searchRestaurants,
    );
    testQuery = 'test Restaurant';
    testFailure = RestaurantsFailure(
      message: 'message',
      statusCode: 400,
    );
    registerFallbackValue(testQuery);
    registerFallbackValue(testFailure);
  });

  tearDown(() => cubit.close());

  test(
    'given SearchRestaurantsCubit '
    'when bloc is instantiated '
    'then initial state should be [SearchRestaurantsInitial] ',
    () async {
      // Arrange
      // Act
      // Assert
      expect(cubit.state, const SearchRestaurantsInitial());
    },
  );

  group('searchRestaurants', () {
    final testRestaurants = <Restaurant>[];
    blocTest<SearchRestaurantsCubit, SearchRestaurantsState>(
      'given SearchRestaurantsCubit '
      'when [SearchRestaurantsCubit.searchRestaurants] is called '
      'and completed successfully '
      'then emit [SearchingRestaurants, RestaurantsSearched] ',
      build: () {
        when(() => searchRestaurants(any())).thenAnswer(
          (_) async => Right(
            testRestaurants,
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.searchRestaurants(testQuery),
      expect: () => [
        const SearchingRestaurants(),
        RestaurantsSearched(
          restaurants: testRestaurants,
        ),
      ],
      verify: (cubit) {
        verify(() => searchRestaurants(testQuery)).called(1);
        verifyNoMoreInteractions(searchRestaurants);
      },
    );
    blocTest<SearchRestaurantsCubit, SearchRestaurantsState>(
      'given SearchRestaurantsCubit '
      'when [SearchRestaurantsCubit.searchRestaurants] is called '
      'and unsuccessful '
      'then emit [SearchingRestaurants, SearchRestaurantsError]',
      build: () {
        when(() => searchRestaurants(any())).thenAnswer(
          (_) async => Left(
            testFailure,
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.searchRestaurants(testQuery),
      expect: () => [
        const SearchingRestaurants(),
        SearchRestaurantsError(message: testFailure.message),
      ],
      verify: (cubit) {
        verify(() => searchRestaurants(testQuery)).called(1);
        verifyNoMoreInteractions(searchRestaurants);
      },
    );
  });
}
