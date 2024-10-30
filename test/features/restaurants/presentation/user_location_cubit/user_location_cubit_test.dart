import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';
import 'package:sheveegan/features/restaurants/presentation/user_location_cubit/user_location_cubit.dart';

class MockGetUserLocation extends Mock implements GetUserLocation {}

void main() {
  late GetUserLocation getUserLocation;
  late UserLocationCubit cubit;
  late UserLocationFailure testFailure;
  late UserLocation testUserLocation;
  setUp(() {
    getUserLocation = MockGetUserLocation();
    cubit = UserLocationCubit(
      getUserLocation: getUserLocation,
    );
    testUserLocation = UserLocation.empty();
    testFailure = UserLocationFailure(
      message: 'message',
      statusCode: 400,
    );
    registerFallbackValue(testUserLocation);
    registerFallbackValue(testFailure);
  });

  tearDown(() => cubit.close());

  test(
    'given UserLocationCubit '
    'when cubit is instantiated '
    'then initial state should be [UserLocationInitial] ',
    () async {
      // Arrange
      // Act
      // Assert
      expect(cubit.state, const UserLocationInitial());
    },
  );

  group('getUserLocation', () {
    blocTest<UserLocationCubit, UserLocationState>(
      'given UserLocationCubit '
      'when [UserLocationCubit.getUserLocation] is called '
      'and completed successfully '
      'then emit [LoadingUserLocation, UserLocationLoaded] ',
      // Arrange
      build: () {
        when(() => getUserLocation()).thenAnswer(
          (_) async => Right(testUserLocation),
        );
        return cubit;
      },
      // Act
      act: (cubit) => cubit.loadGeoLocation(),
      // Assert
      expect: () => [
        const LoadingUserLocation(),
        UserLocationLoaded(
          position: testUserLocation.position,
        ),
      ],
    );

    blocTest<UserLocationCubit, UserLocationState>(
      'given UserLocationCubit '
      'when [UserLocationCubit.getUserLocation] is called '
      'and unsuccessful '
      'then emit [LoadingUserLocation, UserLocationError] ',
      // Arrange
      build: () {
        when(() => getUserLocation()).thenAnswer(
          (_) async => Left(testFailure),
        );
        return cubit;
      },
      // Act
      act: (cubit) => cubit.loadGeoLocation(),
      // Assert
      expect: () => [
        const LoadingUserLocation(),
        UserLocationError(message: testFailure.errorMessage),
      ],
    );
  });
}
