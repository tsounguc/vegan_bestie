import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/repositories/restaurants_repository_impl.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class MockRestaurantsRemoteDataSource extends Mock implements RestaurantsRemoteDataSource {}

void main() {
  late RestaurantsRemoteDataSource remoteDataSource;
  late RestaurantsRepositoryImpl repositoryImpl;
  late RestaurantsException testRestaurantsException;
  late RestaurantDetailsException testRestaurantDetailsException;
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
    final testRestaurants = <Restaurant>[];
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
    final testRestaurantDetails = RestaurantDetails.empty();
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
        ).thenAnswer(
          (_) async => testRestaurantDetails,
        );
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
              RestaurantDetailsFailure.fromException(testRestaurantDetailsException),
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
}
