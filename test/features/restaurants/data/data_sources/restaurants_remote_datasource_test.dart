import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/restaurants_services/location_plugin.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';

class MockLocationPlugin extends Mock implements LocationPlugin {}

Future<void> main() async {
  late RestaurantsRemoteDataSource remoteDataSource;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;
  late MockFirebaseStorage storage;
  late LocationPlugin location;
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

    remoteDataSource = RestaurantsRemoteDataSourceImpl(
      firestore,
      storage,
      auth,
      location,
    );
    testRestaurantsException = const RestaurantsException(
      message: 'message',
      statusCode: 501,
    );

    registerFallbackValue(testRestaurant);
    registerFallbackValue(testPosition);
    registerFallbackValue(testRadius);
  });

  group('addRestaurant', () {
    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.addRestaurant] is called '
      'then add the given restaurant to the firestore collection ',
      () async {
        // Arrange

        // Act
        await remoteDataSource.addRestaurant(
          restaurant: testRestaurant,
        );

        // Assert
        final firestoreData = await firestore.collection('restaurants').get();
        expect(firestoreData.docs.length, 1);

        final restaurantReference = firestoreData.docs.first;
        expect(restaurantReference.data()['id'], restaurantReference.id);
      },
    );
  });

  group('getRestaurants', () {
    test(
      'given RestaurantRemoteDataSourceImpl '
      'when [RestaurantRemoteDataSourceImpl.getRestaurants] is called '
      'then return a List<Restaurant> ',
      () async {
        // Arrange
        // final firstDate = DateTime.now();
        // final secondDate = DateTime.now().add(const Duration(seconds: 20));
        const expectedRestaurants = [
          RestaurantModel.empty(),
          RestaurantModel.empty(),
        ];

        for (final restaurant in expectedRestaurants) {
          await firestore.collection('restaurants').add(restaurant.toMap());
        }

        // Act
        final result = await remoteDataSource.getRestaurantsNearMe(
          position: testPosition,
          radius: testRadius,
        );

        // Assert
        expect(result, expectedRestaurants);
      },
    );
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
      ).thenThrow(const UserLocationException(message: 'message'));
      // Act
      final methodCall = remoteDataSource.getUserLocation;

      // Assert
      expect(
        () async => methodCall(),
        throwsA(const UserLocationException(message: 'message')),
      );

      verify(() => location.getCurrentLocation()).called(1);
      verifyNoMoreInteractions(location);
    });
  });
}
