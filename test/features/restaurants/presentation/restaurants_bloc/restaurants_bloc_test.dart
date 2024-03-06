import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class MockGetRestaurantsNearMe extends Mock implements GetRestaurantsNearMe {}

class MockGetRestaurantDetails extends Mock implements GetRestaurantDetails {}

void main() {
  late GetRestaurantsNearMe getRestaurantsNearMe;
  late GetRestaurantDetails getRestaurantDetails;
  late RestaurantsBloc bloc;
  late GetRestaurantsNearMeParams testGetRestaurantsParams;
  late RestaurantsFailure testRestaurantsFailure;

  setUp(() {
    getRestaurantsNearMe = MockGetRestaurantsNearMe();
    getRestaurantDetails = MockGetRestaurantDetails();
    bloc = RestaurantsBloc(
      getRestaurantsNearMe: getRestaurantsNearMe,
      getRestaurantDetails: getRestaurantDetails,
    );
    testGetRestaurantsParams = GetRestaurantsNearMeParams.empty();
    testRestaurantsFailure = const RestaurantsFailure(
      message: 'message',
      statusCode: 400,
    );
    registerFallbackValue(testGetRestaurantsParams);
  });

  tearDown(() => bloc.close());

  test(
      'given RestaurantsBloc '
      'when cubit is instantiated '
      'then initial should be [RestaurantsInitial]', () async {
    // Arrange
    // Act
    // Assert
    expect(bloc.state, const RestaurantsInitial());
  });

  group('getRestaurantsNearMe -', () {
    final testRestaurants = <Restaurant>[];
    testGetRestaurantsParams = GetRestaurantsNearMeParams.empty();
    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getRestaurantsNearMe] is called and completed successfully '
      'then emit [LoadingRestaurants, RestaurantsLoaded]',
      build: () {
        when(() => getRestaurantsNearMe(any())).thenAnswer(
          (_) async => Right(testRestaurants),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetRestaurantsEvent(
          position: testGetRestaurantsParams.position,
        ),
      ),
      expect: () => [
        const LoadingRestaurants(),
        RestaurantsLoaded(restaurants: testRestaurants),
      ],
      verify: (bloc) {
        verify(
          () => getRestaurantsNearMe(testGetRestaurantsParams),
        ).called(1);
        verifyNoMoreInteractions(getRestaurantsNearMe);
      },
    );

    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getRestaurantsNearMe] is called and unsuccessful '
      'then emit [LoadingRestaurants, RestaurantsError]',
      build: () {
        when(() => getRestaurantsNearMe(any())).thenAnswer(
          (_) async => Left(testRestaurantsFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetRestaurantsEvent(
          position: testGetRestaurantsParams.position,
        ),
      ),
      expect: () => [
        const LoadingRestaurants(),
        RestaurantsError(message: testRestaurantsFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(
          () => getRestaurantsNearMe(testGetRestaurantsParams),
        ).called(1);
        verifyNoMoreInteractions(getRestaurantsNearMe);
      },
    );
  });
}
