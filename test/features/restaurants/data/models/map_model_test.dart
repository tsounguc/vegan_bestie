import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';

void main() {
  late MapModel testModel;
  test('', () {});
  setUpAll(() {
    testModel = MapModel.empty();
  });
  test(
    'given [MapModel], '
    'when instantiated '
    'then instance should be a subclass of [MapEntity] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testModel, isA<MapEntity>());
    },
  );
  group('copyWith - ', () {
    final testMarks = {
      const Marker(
        markerId: MarkerId('MarkerId'),
      ),
    };
    test(
        'given [MapModel], '
        'when copyWith is called, '
        'then return [MapModel] with updated data ', () {
      // Arrange
      // Act
      final result = testModel.copyWith(markers: testMarks);
      // Assert
      expect(result.markers, equals(testMarks));
    });
  });
}
