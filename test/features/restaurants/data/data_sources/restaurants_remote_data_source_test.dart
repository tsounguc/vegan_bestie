import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

Future<void> main() async {
  await dotenv.load();
  late Client client;
  late RestaurantsRemoteDataSource remoteDataSource;
  setUp(() {
    client = MockClient();
    remoteDataSource = RestaurantsRemoteDataSourceImpl(client);
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
        expect(restaurants, isA<List<Restaurant>>());
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
}
