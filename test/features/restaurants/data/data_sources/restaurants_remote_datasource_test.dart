import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/restaurants_services/geocoding_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/location_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/map_plugin.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';

class MockLocationPlugin extends Mock implements LocationPlugin {}

class MockGoogleMapPlugin extends Mock implements GoogleMapPlugin {}

class MockGeocodingPlugin extends Mock implements GeocodingPlugin {}

Future<void> main() async {
  late RestaurantsRemoteDataSource remoteDataSource;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;
  late MockFirebaseStorage storage;
  late LocationPlugin location;
  late GoogleMapPlugin googleMap;
  late GeocodingPlugin geocoding;
  late RestaurantsException testRestaurantsException;
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
  const testRestaurant = RestaurantModel.empty();
  final testMapModel = MapModel.empty();
  final testUserLocation = UserLocationModel.empty();
  setUp(() async {
    firestore = FakeFirebaseFirestore();
    final user = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    auth = MockFirebaseAuth(mockUser: user);
    await auth.signInWithCredential(credential);

    storage = MockFirebaseStorage();

    location = MockLocationPlugin();

    googleMap = MockGoogleMapPlugin();

    geocoding = MockGeocodingPlugin();

    remoteDataSource = RestaurantsRemoteDataSourceImpl(
      firestore,
      storage,
      auth,
      location,
      googleMap,
      geocoding,
    );
    testRestaurantsException = const RestaurantsException(
      message: 'message',
      statusCode: 501,
    );

    final restaurantRef = firestore
        .collection(FirebaseConstants.businessesCollection)
        .doc('${FirebaseConstants.restaurantsCollection}')
        .collection('In Washington'.camelCase())
        .doc();

    await restaurantRef.set(
      const RestaurantModel.empty().copyWith(id: testRestaurant.id).toMap(),
    );

    registerFallbackValue(testRestaurant);
    registerFallbackValue(testPosition);
    registerFallbackValue(testRadius);
    registerFallbackValue([testRestaurant]);
  });

  group('addRestaurant', () {
    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.addRestaurant] is called '
      'then add the given restaurant to the firestore collection ',
      () async {
        // Arrange
        when(
          () => geocoding.getCoordinateFromAddress(any()),
        ).thenAnswer(
          (_) async => Location(
            latitude: 0,
            longitude: 0,
            timestamp: DateTime.now(),
          ),
        );
        // Act
        await remoteDataSource.addRestaurant(
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantCollectionRef = await firestore
            .collection(FirebaseConstants.businessesCollection)
            .doc('${FirebaseConstants.restaurantsCollection}')
            .collection('In Washington'.camelCase())
            .get();
        expect(restaurantCollectionRef.docs.length, 1);
        expect(restaurantCollectionRef.docs.first.data()['id'], testRestaurant.id);

        verify(() => geocoding.getCoordinateFromAddress(any())).called(1);
        verifyNoMoreInteractions(geocoding);
      },
    );
  });

  group('getRestaurantsNearMe', () {
    test(
      'given RestaurantRemoteDataSourceImpl '
      'when [RestaurantRemoteDataSourceImpl.getRestaurantsNearMe] is called '
      'then return a List<Restaurant> ',
      () async {
        // Arrange
        when(
          () => geocoding.getPlaceMarkFromPosition(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((invocation) async => const Placemark());
        final expectedRestaurants = [
          const RestaurantModel.empty(),
          const RestaurantModel.empty().copyWith(id: '1'),
        ];

        for (final restaurant in expectedRestaurants) {
          await firestore
              .collection(FirebaseConstants.businessesCollection)
              .doc(FirebaseConstants.restaurantsCollection)
              .collection('In Washington'.camelCase())
              .add(restaurant.toMap());
        }

        // Act
        final result = remoteDataSource.getRestaurantsNearMe(
          position: testPosition,
          radius: testRadius,
        );

        // Assert
        expect(result, emits([equals(expectedRestaurants)]));
      },
    );
  });

  group('getRestaurantsMarkers ', () {
    test(
      'given RestaurantRemoteDataSourceImpl '
      'when [RestaurantRemoteDataSourceImpl.getRestaurantsMarkers] is called '
      'then return a [MapEntity] ',
      () async {
        // Arrange
        when(
          () => googleMap.getRestaurantsMarkers(restaurants: any(named: 'restaurants')),
        ).thenAnswer((_) async => testMapModel);

        // Act
        final result = await remoteDataSource.getRestaurantsMarkers(restaurants: [testRestaurant]);

        // Assert
        expect(result, testMapModel);

        verify(
          () => googleMap.getRestaurantsMarkers(
            restaurants: any(named: 'restaurants'),
          ),
        ).called(1);
        verifyNoMoreInteractions(googleMap);
      },
    );

    test(
        'given RestaurantRemoteDataSourceImpl '
        'when [RestaurantRemoteDataSourceImpl.getRestaurantsMarkers] call is unsuccessful '
        'then throw [MapException]', () async {
      // Arrange
      when(
        () => googleMap.getRestaurantsMarkers(restaurants: any(named: 'restaurants')),
      ).thenThrow((_) async => const MapException(message: 'message'));
      // Act
      final methodCall = remoteDataSource.getRestaurantsMarkers;

      // Assert
      expect(
        () async => methodCall(restaurants: [testRestaurant]),
        throwsA(isA<MapException>()),
      );

      verify(
        () => googleMap.getRestaurantsMarkers(
          restaurants: any(named: 'restaurants'),
        ),
      ).called(1);
      verifyNoMoreInteractions(googleMap);
    });
  });

  group('getUserLocation', () {
    test(
      'given RestaurantRemoteDataSourceImpl '
      'when [RestaurantRemoteDataSourceImpl.getUserLocation] is called '
      'then return a UserLocation ',
      () async {
        // Arrange
        when(
          () => location.getCurrentLocation(),
        ).thenAnswer((_) async => testPosition);

        // Act
        final result = await remoteDataSource.getUserLocation();

        // Assert
        expect(result, isA<UserLocation>());

        verify(() => location.getCurrentLocation()).called(1);
        verifyNoMoreInteractions(location);
      },
    );

    test(
        'given RestaurantRemoteDataSourceImpl '
        'when [RestaurantRemoteDataSourceImpl.getUserLocation] call is unsuccessful '
        'then throw [UserLocationException] ', () async {
      // Arrange
      when(
        () => location.getCurrentLocation(),
      ).thenThrow((_) async => const UserLocationException(message: 'message'));
      // Act
      final methodCall = remoteDataSource.getUserLocation;

      // Assert
      expect(
        () async => methodCall(),
        throwsA(isA<UserLocationException>()),
      );

      verify(() => location.getCurrentLocation()).called(1);
      verifyNoMoreInteractions(location);
    });
  });
}
