import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';

class MapModel extends MapEntity {
  MapModel({required super.markers});

  MapModel.empty() : this(markers: {});
}
