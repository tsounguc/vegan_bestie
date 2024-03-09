import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_details_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/data/repositories/restaurants_repository_impl.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRestaurantsRemoteDataSource extends Mock implements RestaurantsRemoteDataSource {}

void main() {
  late RestaurantsRemoteDataSource remoteDataSource;
  late RestaurantsRepositoryImpl repositoryImpl;
  late RestaurantsException testRestaurantsException;
  late RestaurantDetailsException testRestaurantDetailsException;
  late UserLocationException testUserLocationException;
  late MapException testMapException;
  setUp(() {
    remoteDataSource = MockRestaurantsRemoteDataSource();
    repositoryImpl = RestaurantsRepositoryImpl(remoteDataSource);
    testRestaurantsException = const RestaurantsException(
      message: 'message',
      statusCode: 404,
    );
    testRestaurantDetailsException = const RestaurantDetailsException(
      message: 'message',
      statusCode: 500,
    );
    testUserLocationException = const UserLocationException(
      message: 'message',
      statusCode: 501,
    );

    testMapException = const MapException(
      message: 'message',
      statusCode: 501,
    );

    registerFallbackValue(
      Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      ),
    );
  });

  test(
    'given RestaurantsRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [RestaurantsRepository]',
    () {
      expect(repositoryImpl, isA<RestaurantsRepository>());
    },
  );

  group('getRestaurantsNearMe - ', () {
    final testRestaurants = <RestaurantModel>[];
    final testPosition = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getRestaurantsNearMe] is called '
      'then complete call to remote data source successfully '
      'and return a [List<Restaurant>]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantsNearMe(
            position: any(named: 'position'),
          ),
        ).thenAnswer(
          (_) async => testRestaurants,
        );
        // Act
        final result = await repositoryImpl.getRestaurantsNearMe(
          position: testPosition,
        );
        // Assert
        expect(
          result,
          equals(
            Right<Failure, List<Restaurant>>(
              testRestaurants,
            ),
          ),
        );
        verify(
          () => remoteDataSource.getRestaurantsNearMe(
            position: testPosition,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getRestaurantsNearMe] is called '
      'and remote data source call is unsuccessful '
      'then return [RestaurantsFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantsNearMe(position: testPosition),
        ).thenThrow(testRestaurantsException);
        // Act
        final result = await repositoryImpl.getRestaurantsNearMe(
          position: testPosition,
        );
        // Assert
        expect(
          result,
          equals(
            Left<Failure, List<Restaurant>>(
              RestaurantsFailure.fromException(testRestaurantsException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.getRestaurantsNearMe(position: testPosition),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getRestaurantDetails - ', () {
    final jsonResponse = fixture('restaurant_details.json');
    final testRestaurantDetails = RestaurantDetailsModel.fromJson(jsonResponse);
    const testId = 'whatever.Id';
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getRestaurantDetails] is called '
      'then complete call to remote data source successfully '
      'and return a [RestaurantDetails]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantDetails(id: any(named: 'id')),
        ).thenAnswer((_) async => testRestaurantDetails);
        // Act
        final result = await repositoryImpl.getRestaurantDetails(
          id: testId,
        );
        // Assert
        expect(
          result,
          equals(
            Right<Failure, RestaurantDetails>(
              testRestaurantDetails,
            ),
          ),
        );
        verify(
          () => remoteDataSource.getRestaurantDetails(
            id: testId,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getRestaurantDetails] is called '
      'and remote data source call is unsuccessful '
      'then return [RestaurantDetailsFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantDetails(id: testId),
        ).thenThrow(testRestaurantDetailsException);
        // Act
        final result = await repositoryImpl.getRestaurantDetails(
          id: testId,
        );
        // Assert
        expect(
          result,
          equals(
            Left<Failure, RestaurantDetails>(
              RestaurantDetailsFailure.fromException(
                testRestaurantDetailsException,
              ),
            ),
          ),
        );
        verify(
          () => remoteDataSource.getRestaurantDetails(id: testId),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getUserLocation - ', () {
    final testUserLocation = UserLocationModel.empty();
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getUserLocation] is called '
      'then complete call to remote data source successfully '
      'and return a [UserLocation]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getUserLocation(),
        ).thenAnswer((_) async => testUserLocation);
        // Act
        final result = await repositoryImpl.getUserLocation();
        // Assert
        expect(
          result,
          equals(
            Right<Failure, UserLocation>(
              testUserLocation,
            ),
          ),
        );
        verify(
          () => remoteDataSource.getUserLocation(),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getUserLocation] is called '
      'and remote data source call is unsuccessful '
      'then return [UserLocationFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getUserLocation(),
        ).thenThrow(testUserLocationException);
        // Act
        final result = await repositoryImpl.getUserLocation();
        // Assert
        expect(
          result,
          equals(
            Left<Failure, UserLocation>(
              UserLocationFailure.fromException(testUserLocationException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.getUserLocation(),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getRestaurantsMarkers - ', () {
    final testMapModel = MapModel.empty();
    final testRestaurants = <Restaurant>[];
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getRestaurantsMarkers] is called '
      'then complete call to remote data source successfully '
      'and return a [MapEntity] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantsMarkers(
            restaurants: testRestaurants,
          ),
        ).thenAnswer((_) async => testMapModel);
        // Act
        final result = await repositoryImpl.getRestaurantsMarkers(
          restaurants: testRestaurants,
        );
        // Assert
        expect(
          result,
          equals(
            Right<Failure, MapEntity>(
              testMapModel,
            ),
          ),
        );
        verify(
          () => remoteDataSource.getRestaurantsMarkers(
            restaurants: testRestaurants,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getUserLocation] is called '
      'and remote data source call is unsuccessful '
      'then return [UserLocationFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantsMarkers(
            restaurants: testRestaurants,
          ),
        ).thenThrow(testMapException);
        // Act
        final result = await repositoryImpl.getRestaurantsMarkers(
          restaurants: testRestaurants,
        );
        // Assert
        expect(
          result,
          equals(
            Left<Failure, MapEntity>(
              MapFailure.fromException(testMapException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.getRestaurantsMarkers(
            restaurants: testRestaurants,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
