import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_markers.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class MockGetRestaurantsNearMe extends Mock implements GetRestaurantsNearMe {}

class MockGetRestaurantDetails extends Mock implements GetRestaurantDetails {}

class MockGetUserLocation extends Mock implements GetUserLocation {}

class MockGetRestaurantsMarkers extends Mock implements GetRestaurantsMarkers {}

void main() {
  late GetRestaurantsNearMe getRestaurantsNearMe;
  late GetRestaurantDetails getRestaurantDetails;
  late GetUserLocation getUserLocation;
  late GetRestaurantsMarkers getRestaurantsMarkers;
  late RestaurantsBloc bloc;
  late GetRestaurantsNearMeParams testGetRestaurantsParams;
  late GetRestaurantDetailsParams testGetRestaurantDetailsParams;
  late GetRestaurantsMarkersParams testGetRestaurantsMarkersParams;

  late RestaurantsFailure testRestaurantsFailure;
  late RestaurantDetailsFailure testRestaurantDetailsFailure;
  late UserLocationFailure testUserLocationFailure;
  late MapFailure testMapFailure;

  setUp(() {
    getRestaurantsNearMe = MockGetRestaurantsNearMe();
    getRestaurantDetails = MockGetRestaurantDetails();
    getUserLocation = MockGetUserLocation();
    getRestaurantsMarkers = MockGetRestaurantsMarkers();
    bloc = RestaurantsBloc(
      getRestaurantsNearMe: getRestaurantsNearMe,
      getRestaurantDetails: getRestaurantDetails,
      getUserLocation: getUserLocation,
      getRestaurantsMarkers: getRestaurantsMarkers,
    );
    testGetRestaurantsParams = GetRestaurantsNearMeParams.empty();
    testGetRestaurantDetailsParams = const GetRestaurantDetailsParams.empty();
    testGetRestaurantsMarkersParams = GetRestaurantsMarkersParams.empty();
    testRestaurantsFailure = const RestaurantsFailure(
      message: 'message',
      statusCode: 400,
    );

    testRestaurantDetailsFailure = const RestaurantDetailsFailure(
      message: 'message',
      statusCode: 400,
    );

    testUserLocationFailure = const UserLocationFailure(
      message: 'message',
      statusCode: 400,
    );

    testMapFailure = const MapFailure(
      message: 'message',
      statusCode: 500,
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
    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getRestaurantsNearMe] is called'
      ' and completed successfully '
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

  group('getRestaurantDetails -', () {
    final testRestaurantDetails = RestaurantDetails.empty();
    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getRestaurantDetails] is called '
      'and completed successfully '
      'then emit [LoadingRestaurantDetails, RestaurantDetailsLoaded]',
      build: () {
        when(
          () => getRestaurantDetails(testGetRestaurantDetailsParams),
        ).thenAnswer((_) async => Right(testRestaurantDetails));
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetRestaurantDetailsEvent(id: testGetRestaurantDetailsParams.id),
      ),
      expect: () => [
        const LoadingRestaurantDetails(),
        RestaurantDetailsLoaded(restaurantDetails: testRestaurantDetails),
      ],
      verify: (bloc) {
        verify(
          () => getRestaurantDetails(testGetRestaurantDetailsParams),
        ).called(1);
        verifyNoMoreInteractions(getRestaurantDetails);
      },
    );

    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getRestaurantDetails] is called and unsuccessful '
      'then emit [LoadingRestaurantDetails, RestaurantsError]',
      build: () {
        when(
          () => getRestaurantDetails(testGetRestaurantDetailsParams),
        ).thenAnswer((_) async => Left(testRestaurantDetailsFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetRestaurantDetailsEvent(id: testGetRestaurantDetailsParams.id),
      ),
      expect: () => [
        const LoadingRestaurantDetails(),
        RestaurantsError(message: testRestaurantsFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(
          () => getRestaurantDetails(testGetRestaurantDetailsParams),
        ).called(1);
        verifyNoMoreInteractions(getRestaurantDetails);
      },
    );
  });

  group('getUserLocation - ', () {
    final testUserLocation = UserLocation.empty();
    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getUserLocation] is called '
      'and completed successfully '
      'then emit [LoadingUserGeoLocation, UserLocationLoaded]',
      build: () {
        when(() => getUserLocation()).thenAnswer(
          (_) async => Right(testUserLocation),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadGeolocationEvent()),
      expect: () => [
        const LoadingUserGeoLocation(),
        UserLocationLoaded(position: testUserLocation.position),
      ],
      verify: (bloc) {
        verify(() => getUserLocation()).called(1);
        verifyNoMoreInteractions(getUserLocation);
      },
    );

    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getUserLocation] is called and unsuccessful '
      'then emit [LoadingUserGeoLocation, RestaurantsError]',
      build: () {
        when(() => getUserLocation()).thenAnswer(
          (_) async => Left(testUserLocationFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadGeolocationEvent()),
      expect: () => [
        const LoadingUserGeoLocation(),
        RestaurantsError(message: testUserLocationFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(() => getUserLocation()).called(1);
        verifyNoMoreInteractions(getUserLocation);
      },
    );
  });

  group('getRestaurantsMarkers - ', () {
    final testMapEntity = MapEntity.empty();
    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getRestaurantsMarkers] is called '
      'and completed successfully '
      'then emit [LoadingMarkers, MarkersLoaded]',
      build: () {
        when(
          () => getRestaurantsMarkers(testGetRestaurantsMarkersParams),
        ).thenAnswer((_) async => Right(testMapEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetRestaurantsMarkersEvent(
          restaurants: testGetRestaurantsMarkersParams.restaurants,
        ),
      ),
      expect: () => [
        const LoadingMarkers(),
        MarkersLoaded(markers: testMapEntity.markers),
      ],
      verify: (bloc) {
        verify(
          () => getRestaurantsMarkers(testGetRestaurantsMarkersParams),
        ).called(1);
        verifyNoMoreInteractions(getRestaurantsMarkers);
      },
    );

    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.getRestaurantsMarkers] is called and unsuccessful '
      'then emit [LoadingMarkers, RestaurantsError]',
      build: () {
        when(
          () => getRestaurantsMarkers(testGetRestaurantsMarkersParams),
        ).thenAnswer(
          (_) async => Left(testMapFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetRestaurantsMarkersEvent(
          restaurants: testGetRestaurantsMarkersParams.restaurants,
        ),
      ),
      expect: () => [
        const LoadingMarkers(),
        RestaurantsError(message: testMapFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(
          () => getRestaurantsMarkers(testGetRestaurantsMarkersParams),
        ).called(1);
        verifyNoMoreInteractions(getRestaurantsMarkers);
      },
    );
  });
}
