import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/restaurants_services/location_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/map_plugin.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

class MockLocationPlugin extends Mock implements LocationPlugin {}

class MockGoogleMapPlugin extends Mock implements GoogleMapPlugin {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

Future<void> main() async {
  await dotenv.load();
  late Client client;
  late LocationPlugin locationPlugin;
  late GoogleMapPlugin googleMapPlugin;
  late RestaurantsRemoteDataSource remoteDataSource;
  late FirebaseAuth authClient;
  late FirebaseStorage dbClient;
  late FirebaseFirestore cloudStoreClient;
  setUp(() async {
    // instantiate Firebase Auth client
    authClient = MockFirebaseAuth();

    // instantiate FireStore client
    cloudStoreClient = FakeFirebaseFirestore();
    client = MockClient();
    locationPlugin = MockLocationPlugin();
    googleMapPlugin = MockGoogleMapPlugin();
    dbClient = MockFirebaseStorage();
    remoteDataSource = RestaurantsRemoteDataSourceImpl(
      client,
      locationPlugin,
      googleMapPlugin,
      cloudStoreClient,
      dbClient,
      authClient,
    );
    registerFallbackValue(Uri());
  });

  final headers = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};
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
  group('getRestaurantsNearMe - ', () {
    final jsonResponse = fixture('restaurants_near_me_response.json');

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.getRestaurantsNearMe] is called '
      'and status is 200 or 201 '
      'then return [List<Restaurant>] ',
      () async {
        // Arrange
        when(
          () => client.get(
            any(),
          ),
        ).thenAnswer(
          (_) async => Response(jsonResponse, 200, headers: headers),
        );
        // Act
        final restaurants = await remoteDataSource.getRestaurantsNearMe(
          position: testPosition,
        );

        // Assert
        expect(restaurants, isA<List<RestaurantEntity>>());
        verify(() => client.get(any())).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.getRestaurantsNearMe] is called '
      'and status is not 200 or 201 '
      'then throw [RestaurantsException]',
      () async {
        // Arrange
        when(() => client.get(any())).thenAnswer(
          (_) async => Response('Server Down', 500, headers: headers),
        );
        // Act
        final methodCall = remoteDataSource.getRestaurantsNearMe;
        // Assert
        expect(
          () => methodCall(position: testPosition),
          throwsA(
            const RestaurantsException(message: 'Server Down', statusCode: 500),
          ),
        );
        verify(() => client.get(any())).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getRestaurantDetails - ', () {
    final jsonResponse = fixture('restaurant_details_response.json');
    const testId = 'ajdkfjowfownwijewf';
    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.getRestaurantDetails] is called '
      'and status is 200 or 201 '
      'then return [RestaurantDetails] ',
      () async {
        // Arrange
        when(
          () => client.get(
            any(),
          ),
        ).thenAnswer(
          (_) async => Response(jsonResponse, 200, headers: headers),
        );
        // Act
        final restaurantDetails = await remoteDataSource.getRestaurantDetails(
          id: testId,
        );

        // Assert
        expect(restaurantDetails, isA<RestaurantDetails>());
        verify(() => client.get(any())).called(1);
        verifyNoMoreInteractions(client);
      },
    );
    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.getRestaurantDetails] is called '
      'and status is not 200 or 201 '
      'then throw [RestaurantsException]',
      () async {
        // Arrange
        when(() => client.get(any())).thenAnswer(
          (_) async => Response('Server Down', 500, headers: headers),
        );
        // Act
        final methodCall = remoteDataSource.getRestaurantsNearMe;
        // Assert
        expect(
          () async => methodCall(position: testPosition),
          throwsA(
            const RestaurantsException(message: 'Server Down', statusCode: 500),
          ),
        );
        verify(() => client.get(any())).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUserLocation - ', () {
    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.getUserLocation] is called '
      'and location permission granted '
      'then return [UserLocation] ',
      () async {
        // Arrange
        when(
          () => locationPlugin.getCurrentLocation(),
        ).thenAnswer((_) async => testPosition);
        // Act
        final userLocation = await remoteDataSource.getUserLocation();

        // Assert
        expect(userLocation, isA<UserLocation>());
        verify(() => locationPlugin.getCurrentLocation()).called(1);
        verifyNoMoreInteractions(locationPlugin);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.getUserLocation] is called '
      'and location permission is not granted '
      'then throw [UserLocationException]',
      () async {
        // Arrange
        when(() => locationPlugin.getCurrentLocation()).thenThrow(
          const UserLocationException(
            message: 'Location permission Denied',
          ),
        );
        // Act
        final methodCall = remoteDataSource.getUserLocation;
        // Assert
        expect(
          () async => methodCall(),
          throwsA(
            const UserLocationException(
              message: 'Location permission Denied',
            ),
          ),
        );
        verify(() => locationPlugin.getCurrentLocation()).called(1);
        verifyNoMoreInteractions(locationPlugin);
      },
    );
  });

  group('getRestaurantsMarkers - ', () {
    final testRestaurants = <RestaurantEntity>[];
    final testMapModel = MapModel.empty();
    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.getRestaurantsMarkers] '
      'successfully called then return [MapModel] ',
      () async {
        // Arrange
        when(
          () => googleMapPlugin.getRestaurantsMarkers(testRestaurants),
        ).thenAnswer((_) async => testMapModel);
        // Act
        final result = await remoteDataSource.getRestaurantsMarkers(
          restaurants: testRestaurants,
        );

        // Assert
        expect(result, isA<MapModel>());
        verify(
          () => googleMapPlugin.getRestaurantsMarkers(testRestaurants),
        ).called(1);
        verifyNoMoreInteractions(googleMapPlugin);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.getRestaurantsMarkers] '
      'call unsuccessful '
      'then throw [MapException]',
      () async {
        // Arrange
        when(
          () => googleMapPlugin.getRestaurantsMarkers(testRestaurants),
        ).thenThrow(
          const MapException(
            message: 'message',
          ),
        );
        // Act
        final methodCall = remoteDataSource.getRestaurantsMarkers;
        // Assert
        expect(
          () async => methodCall(
            restaurants: testRestaurants,
          ),
          throwsA(
            const MapException(
              message: 'message',
            ),
          ),
        );
        verify(
          () => googleMapPlugin.getRestaurantsMarkers(testRestaurants),
        ).called(1);
        verifyNoMoreInteractions(googleMapPlugin);
      },
    );
  });
}
