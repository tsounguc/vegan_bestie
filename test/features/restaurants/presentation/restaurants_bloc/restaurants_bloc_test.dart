import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/auth/domain/usecases/remove_restaurant.dart';
import 'package:sheveegan/features/auth/domain/usecases/save_restaurant.dart';
import 'package:sheveegan/features/food_product/domain/use_cases/get_saved_restaurants_list.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/add_restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/add_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/delete_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/edit_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_reviews.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_markers.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class MockAddRestaurant extends Mock implements AddRestaurant {}

class MockGetRestaurantsNearMe extends Mock implements GetRestaurantsNearMe {}

// class MockGetRestaurantDetails extends Mock implements GetRestaurantDetails {}

class MockGetUserLocation extends Mock implements GetUserLocation {}

class MockGetRestaurantsMarkers extends Mock implements GetRestaurantsMarkers {}

// class MockGetSavedRestaurantsList extends Mock implements GetSavedRestaurantsList {}

// class MockSaveRestaurant extends Mock implements SaveRestaurant {}

// class MockRemoveRestaurant extends Mock implements RemoveRestaurant {}

// class MockAddRestaurantReview extends Mock implements AddRestaurantReview {}

// class MockGetRestaurantReviews extends Mock implements GetRestaurantReviews {}

// class MockDeleteRestaurantReview extends Mock implements DeleteRestaurantReview {}

// class MockEditRestaurantReview extends Mock implements EditRestaurantReview {}

void main() {
  late GetRestaurantsNearMe getRestaurantsNearMe;
  late AddRestaurant addRestaurant;
  // late GetRestaurantDetails getRestaurantDetails;
  late GetUserLocation getUserLocation;
  late GetRestaurantsMarkers getRestaurantsMarkers;
  // late DeleteRestaurantReview deleteRestaurantReview;
  late RestaurantsBloc bloc;
  late GetRestaurantsNearMeParams testGetRestaurantsParams;
  // late GetRestaurantDetailsParams testGetRestaurantDetailsParams;
  late GetRestaurantsMarkersParams testGetRestaurantsMarkersParams;

  late RestaurantsFailure testRestaurantsFailure;
  late RestaurantDetailsFailure testRestaurantDetailsFailure;
  late UserLocationFailure testUserLocationFailure;
  late MapFailure testMapFailure;
  late Restaurant testRestaurant;

  setUp(() {
    addRestaurant = MockAddRestaurant();
    getRestaurantsNearMe = MockGetRestaurantsNearMe();
    // getRestaurantDetails = MockGetRestaurantDetails();
    getUserLocation = MockGetUserLocation();
    getRestaurantsMarkers = MockGetRestaurantsMarkers();
    // deleteRestaurantReview = MockDeleteRestaurantReview();
    bloc = RestaurantsBloc(
      getRestaurantsNearMe: getRestaurantsNearMe,
      // getRestaurantDetails: getRestaurantDetails,
      getUserLocation: getUserLocation,
      addRestaurant: addRestaurant,
      getRestaurantsMarkers: getRestaurantsMarkers,
      // getSavedRestaurantsList: MockGetSavedRestaurantsList(),
      // saveRestaurant: MockSaveRestaurant(),
      // removeRestaurant: MockRemoveRestaurant(),
      // addRestaurantReview: MockAddRestaurantReview(),
      // getRestaurantReviews: MockGetRestaurantReviews(),
      // deleteRestaurantReview: MockDeleteRestaurantReview(),
      // editRestaurantReview: MockEditRestaurantReview(),
    );
    testRestaurant = const Restaurant.empty();
    testGetRestaurantsParams = GetRestaurantsNearMeParams.empty();
    // testGetRestaurantDetailsParams = const GetRestaurantDetailsParams.empty();
    testGetRestaurantsMarkersParams = GetRestaurantsMarkersParams.empty();
    testRestaurantsFailure = RestaurantsFailure(
      message: 'message',
      statusCode: 400,
    );

    testRestaurantDetailsFailure = RestaurantDetailsFailure(
      message: 'message',
      statusCode: 400,
    );

    testUserLocationFailure = UserLocationFailure(
      message: 'message',
      statusCode: 400,
    );

    testMapFailure = MapFailure(
      message: 'message',
      statusCode: 500,
    );
    registerFallbackValue(testGetRestaurantsParams);
    registerFallbackValue(testRestaurant);
  });

  tearDown(() => bloc.close());

  test(
      'given RestaurantsBloc '
      'when bloc is instantiated '
      'then initial state should be [RestaurantsInitial]', () async {
    // Arrange
    // Act
    // Assert
    expect(bloc.state, const RestaurantsInitial());
  });

  group('addRestaurants -', () {
    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.addRestaurants] is called'
      ' and completed successfully '
      'then emit [AddingRestaurant, RestaurantsAdded]',
      build: () {
        when(() => addRestaurant(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        AddRestaurantEvent(restaurant: testRestaurant),
      ),
      expect: () => [
        const AddingRestaurant(),
        const RestaurantAdded(),
      ],
      verify: (bloc) {
        verify(
          () => addRestaurant(testRestaurant),
        ).called(1);
        verifyNoMoreInteractions(addRestaurant);
      },
    );

    blocTest<RestaurantsBloc, RestaurantsState>(
      'given RestaurantsBloc '
      'when [RestaurantsBloc.addRestaurant] is called and unsuccessful '
      'then emit [AddingRestaurant, RestaurantsError]',
      build: () {
        when(() => addRestaurant(any())).thenAnswer(
          (_) async => Left(testRestaurantsFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        AddRestaurantEvent(restaurant: testRestaurant),
      ),
      expect: () => [
        const AddingRestaurant(),
        RestaurantsError(message: testRestaurantsFailure.errorMessage),
      ],
      verify: (cubit) {
        verify(
          () => addRestaurant(testRestaurant),
        ).called(1);
        verifyNoMoreInteractions(addRestaurant);
      },
    );
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
          (_) => Stream.value(Right(testRestaurants)),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetRestaurantsEvent(
          position: testGetRestaurantsParams.position,
          radius: testGetRestaurantsParams.radius,
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
          (_) => Stream.value(Left(testRestaurantsFailure)),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetRestaurantsEvent(
          position: testGetRestaurantsParams.position,
          radius: testGetRestaurantsParams.radius,
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

  // group('getRestaurantDetails -', () {
  //   final testRestaurantDetails = RestaurantDetails.empty();
  //   blocTest<RestaurantsBloc, RestaurantsState>(
  //     'given RestaurantsBloc '
  //     'when [RestaurantsBloc.getRestaurantDetails] is called '
  //     'and completed successfully '
  //     'then emit [LoadingRestaurantDetails, RestaurantDetailsLoaded]',
  //     build: () {
  //       when(
  //         () => getRestaurantDetails(testGetRestaurantDetailsParams),
  //       ).thenAnswer((_) async => Right(testRestaurantDetails));
  //       return bloc;
  //     },
  //     act: (bloc) => bloc.add(
  //       GetRestaurantDetailsEvent(id: testGetRestaurantDetailsParams.id),
  //     ),
  //     expect: () => [
  //       const LoadingRestaurantDetails(),
  //       RestaurantDetailsLoaded(restaurantDetails: testRestaurantDetails),
  //     ],
  //     verify: (bloc) {
  //       verify(
  //         () => getRestaurantDetails(testGetRestaurantDetailsParams),
  //       ).called(1);
  //       verifyNoMoreInteractions(getRestaurantDetails);
  //     },
  //   );
  //
  //   blocTest<RestaurantsBloc, RestaurantsState>(
  //     'given RestaurantsBloc '
  //     'when [RestaurantsBloc.getRestaurantDetails] is called and unsuccessful '
  //     'then emit [LoadingRestaurantDetails, RestaurantsError]',
  //     build: () {
  //       when(
  //         () => getRestaurantDetails(testGetRestaurantDetailsParams),
  //       ).thenAnswer((_) async => Left(testRestaurantDetailsFailure));
  //       return bloc;
  //     },
  //     act: (bloc) => bloc.add(
  //       GetRestaurantDetailsEvent(id: testGetRestaurantDetailsParams.id),
  //     ),
  //     expect: () => [
  //       const LoadingRestaurantDetails(),
  //       RestaurantsError(message: testRestaurantsFailure.errorMessage),
  //     ],
  //     verify: (cubit) {
  //       verify(
  //         () => getRestaurantDetails(testGetRestaurantDetailsParams),
  //       ).called(1);
  //       verifyNoMoreInteractions(getRestaurantDetails);
  //     },
  //   );
  // });
}
