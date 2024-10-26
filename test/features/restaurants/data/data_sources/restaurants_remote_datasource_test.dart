import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/enums/update_restaurant_info.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/services/restaurants_services/geocoding_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/location_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/map_plugin.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
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
  final testUserLocation = UserLocationModel.empty();
  final testGeoLocation = Location(
    latitude: 0,
    longitude: 0,
    timestamp: DateTime.now(),
  );
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

    final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc();

    await restaurantRef.set(
      const RestaurantModel.empty().copyWith(id: testRestaurant.id, streetAddress: 'Test Street').toMap(),
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
        final restaurantCollectionRef = await firestore.collection(FirebaseConstants.restaurantsCollection).get();

        when(
          () => geocoding.getCoordinateFromAddress(any()),
        ).thenAnswer(
          (_) async => testGeoLocation,
        );
        // Act
        await remoteDataSource.addRestaurant(
          restaurant: testRestaurant,
        );

        // Assert

        expect(restaurantCollectionRef.docs.length, 1);
        expect(restaurantCollectionRef.docs.first.data()['id'], testRestaurant.id);

        verify(() => geocoding.getCoordinateFromAddress(any())).called(1);
        verifyNoMoreInteractions(geocoding);
      },
    );
  });

  group('updateRestaurant', () {
    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.name] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testName = 'New Name';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.name,
          restaurantData: testName,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['name'], testName);
        expect(restaurantData.data()!['name_lowercase'], testName.toLowerCase());
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.streetAddress] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testStreetAddress = 'New Address';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        when(() => geocoding.getCoordinateFromAddress(any())).thenAnswer(
          (_) async => testGeoLocation,
        );

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.streetAddress,
          restaurantData: testStreetAddress,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData = await restaurantRef.get();
        expect(restaurantData.data()!['streetAddress'], testStreetAddress);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.city] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testCity = 'New City';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        when(() => geocoding.getCoordinateFromAddress(any())).thenAnswer(
          (_) async => testGeoLocation,
        );

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.city,
          restaurantData: testCity,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData = await restaurantRef.get();
        expect(restaurantData.data()!['city'], testCity);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.state] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testState = 'New State';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        when(() => geocoding.getCoordinateFromAddress(any())).thenAnswer(
          (_) async => testGeoLocation,
        );

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.state,
          restaurantData: testState,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData = await restaurantRef.get();
        expect(restaurantData.data()!['state'], testState);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.zipcode] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testZipcode = 'New zipcode';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        when(() => geocoding.getCoordinateFromAddress(any())).thenAnswer(
          (_) async => testGeoLocation,
        );

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.zipcode,
          restaurantData: testZipcode,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData = await restaurantRef.get();
        expect(restaurantData.data()!['zipcode'], testZipcode);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.description] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testDescription = 'New Description';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.description,
          restaurantData: testDescription,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['description'], testDescription);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.email] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testEmail = 'New Email';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.email,
          restaurantData: testEmail,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['email'], testEmail);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.phoneNumber] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testPhoneNumber = 'New Phone Number';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.phoneNumber,
          restaurantData: testPhoneNumber,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['phoneNumber'], testPhoneNumber);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.websiteUrl] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testWebsiteUrl = 'New Website';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.website,
          restaurantData: testWebsiteUrl,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['websiteUrl'], testWebsiteUrl);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.permanentlyClosed] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testPermanentlyClosed = true;
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.permanentlyClosed,
          restaurantData: testPermanentlyClosed,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['permanentlyClosed'], testPermanentlyClosed);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.openHours] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testOpenHours = OpenHoursModel.empty();
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.openHours,
          restaurantData: testOpenHours,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['openHours'], testOpenHours.toMap());
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.takeout] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testTakeout = true;
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.takeout,
          restaurantData: testTakeout,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['takeout'], testTakeout);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.dineIn] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testDineIn = true;
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.dineIn,
          restaurantData: testDineIn,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['dineIn'], testDineIn);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.delivery] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testDelivery = true;
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.delivery,
          restaurantData: testDelivery,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['delivery'], testDelivery);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.veganStatus] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testVeganStatus = true;
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.veganStatus,
          restaurantData: testVeganStatus,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['veganStatus'], testVeganStatus);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.hasVeganOptions] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testHasVeganOptions = true;
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.hasVeganOptions,
          restaurantData: testHasVeganOptions,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['hasVeganOptions'], testHasVeganOptions);
      },
    );

    test(
      'given RestaurantsRemoteDataSourceImpl '
      'when [RestaurantsRemoteDataSourceImpl.updateRestaurant] is called '
      'and [UpdateRestaurantInfoAction.price] '
      'then update restaurant and complete successfully',
      () async {
        // Arrange
        const testPrice = r'$$$';
        final restaurantRef = firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id);
        await restaurantRef.set(testRestaurant.toMap());

        // Act
        await remoteDataSource.updateRestaurant(
          action: UpdateRestaurantInfoAction.price,
          restaurantData: testPrice,
          restaurant: testRestaurant,
        );

        // Assert
        final restaurantData =
            await firestore.collection(FirebaseConstants.restaurantsCollection).doc(testRestaurant.id).get();
        expect(restaurantData.data()!['price'], testPrice);
      },
    );
  });

  group('getRestaurantsNearMe', () {
    test(
      'given RestaurantRemoteDataSourceImpl '
      'when [RestaurantRemoteDataSourceImpl.getRestaurantsNearMe] is called '
      'then return a [Stream<List<Restaurant>>]',
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
          await firestore.collection(FirebaseConstants.restaurantsCollection).add(restaurant.toMap());
        }

        // Act
        final result = remoteDataSource.getRestaurantsNearMe(
          position: testPosition,
          radius: testRadius,
        );

        // Assert

        final restaurantsCollectionRef = await firestore.collection(FirebaseConstants.restaurantsCollection).get();

        expect(restaurantsCollectionRef.docs.length, 3);
        expect(restaurantsCollectionRef.docs.first.data()['id'], testRestaurant.id);
        // expect(result, emitsInOrder([equals(expectedRestaurants.reversed)]));
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
