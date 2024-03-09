import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/features/restaurants/data/models/user_location_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';

void main() {
  late UserLocationModel testModel;
  setUpAll(() {
    testModel = UserLocationModel.empty();
  });
  test(
    'given [UserLocationModel], '
    'when instantiated '
    'then instance should be a subclass of [UserLocation] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testModel, isA<UserLocation>());
    },
  );
  group('copyWith - ', () {
    final testPostion = Position(
      longitude: 1,
      latitude: 1,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      altitudeAccuracy: 1,
      heading: 1,
      headingAccuracy: 1,
      speed: 1,
      speedAccuracy: 1,
    );
    test(
        'given [BarcodeModel], '
        'when copyWith is called, '
        'then return [BarcodeModel] with updated data ', () {
      // Arrange
      // Act
      final result = testModel.copyWith(position: testPostion);
      // Assert
      expect(result.position, equals(testPostion));
    });
  });
}
