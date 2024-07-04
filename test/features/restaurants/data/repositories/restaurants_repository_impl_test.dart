import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/data/repositories/restaurants_repository_impl.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class MockRestaurantsRemoteDataSource extends Mock implements RestaurantsRemoteDataSource {}

void main() {
  late RestaurantsRemoteDataSource remoteDataSource;
  late RestaurantsRepositoryImpl repositoryImpl;
  late RestaurantsException testRestaurantsException;
  const testRestaurant = RestaurantModel.empty();
  final testRestaurants = [testRestaurant];
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

  const testRadius = 5.0;

  final testMapEntity = MapEntity.empty();

  setUp(() {
    remoteDataSource = MockRestaurantsRemoteDataSource();
    repositoryImpl = RestaurantsRepositoryImpl(remoteDataSource);
    testRestaurantsException = const RestaurantsException(
      message: 'message',
      statusCode: 501,
    );
    registerFallbackValue(testRestaurant);
    registerFallbackValue(testPosition);
    registerFallbackValue(testRadius);
  });

  test(
    'given RestaurantsRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [RestaurantsRepository]',
    () {
      expect(repositoryImpl, isA<RestaurantsRepository>());
    },
  );

  group('getRestaurantsNear', () {
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getRestaurantsNearMe] is called '
      'then complete call to remote data source successfully '
      'and return a [List<Restaurants>]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantsNearMe(
            position: any(named: 'position'),
            radius: any(named: 'radius'),
          ),
        ).thenAnswer((_) => Stream.value(testRestaurants));
        // Act
        final result = await repositoryImpl.getRestaurantsNearMe(
          position: testPosition,
          radius: testRadius,
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
            radius: testRadius,
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
          () => remoteDataSource.getRestaurantsNearMe(
            position: any(named: 'position'),
            radius: any(named: 'radius'),
          ),
        ).thenAnswer((_) => Stream.error(testRestaurantsException));
        // Act
        final result = await repositoryImpl.getRestaurantsNearMe(
          position: testPosition,
          radius: testRadius,
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
          () => remoteDataSource.getRestaurantsNearMe(
            position: testPosition,
            radius: testRadius,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('addRestaurant', () {
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.addRestaurant] is called '
      'then complete call to remote data source successfully '
      'and return [void]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.addRestaurant(restaurant: any(named: 'restaurant')),
        ).thenAnswer(
          (_) async => Future.value(),
        );
        // Act
        final result = await repositoryImpl.addRestaurant(restaurant: testRestaurant);
        // Assert
        expect(
          result,
          equals(
            const Right<Failure, void>(null),
          ),
        );
        verify(
          () => remoteDataSource.addRestaurant(restaurant: testRestaurant),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.addRestaurant] is called '
      'and remote data source call is unsuccessful '
      'then return [RestaurantsFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.addRestaurant(
            restaurant: any(named: 'restaurant'),
          ),
        ).thenThrow(testRestaurantsException);
        // Act
        final result = await repositoryImpl.addRestaurant(restaurant: testRestaurant);
        // Assert
        expect(
          result,
          equals(
            Left<Failure, void>(
              RestaurantsFailure.fromException(testRestaurantsException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.addRestaurant(restaurant: testRestaurant),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getUserLocation', () {
    final testUserLocation = UserLocationModel.empty();
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getUserLocation] is called '
      'then complete call to remote data source successfully '
      'and return [UserLocation]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getUserLocation(),
        ).thenAnswer(
          (_) async => testUserLocation,
        );
        // Act
        final result = await repositoryImpl.getUserLocation();
        // Assert
        expect(
          result,
          equals(
            Right<Failure, UserLocation>(testUserLocation),
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
        ).thenThrow(
          const UserLocationException(message: 'message'),
        );
        // Act
        final result = await repositoryImpl.getUserLocation();
        // Assert
        expect(
          result,
          equals(
            Left<Failure, UserLocation>(
              UserLocationFailure.fromException(const UserLocationException(message: 'message')),
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

  group('getRestaurantMarkers', () {
    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getRestaurantMarkers] is called '
      'then complete call to remote data source successfully '
      'and return [MapEntity]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantsMarkers(
            restaurants: any(named: 'restaurants'),
          ),
        ).thenAnswer((_) async => testMapEntity);
        // Act
        final result = await repositoryImpl.getRestaurantsMarkers(
          restaurants: testRestaurants,
        );
        // Assert
        expect(
          result,
          equals(
            Right<Failure, MapEntity>(testMapEntity),
          ),
        );
        verify(
          () => remoteDataSource.getRestaurantsMarkers(
            restaurants: any(named: 'restaurants'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given RestaurantsRepositoryImpl, '
      'when [RestaurantsRepositoryImpl.getRestaurantsMarkers] is called '
      'and remote data source call is unsuccessful '
      'then return [MapFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRestaurantsMarkers(
            restaurants: any(named: 'restaurants'),
          ),
        ).thenThrow(
          const MapException(message: 'message'),
        );
        // Act
        final result = await repositoryImpl.getRestaurantsMarkers(restaurants: testRestaurants);
        // Assert
        expect(
          result,
          equals(
            Left<Failure, MapEntity>(
              MapFailure.fromException(const MapException(message: 'message')),
            ),
          ),
        );
        verify(
          () => remoteDataSource.getRestaurantsMarkers(
            restaurants: any(named: 'restaurants'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
