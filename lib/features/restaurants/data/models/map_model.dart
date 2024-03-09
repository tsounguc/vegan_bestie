import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';

class MapModel extends MapEntity {
  MapModel({required super.markers});

  MapModel.empty() : this(markers: {});

  MapModel copyWith({Set<Marker>? markers}) {
    return MapModel(markers: markers ?? this.markers);
  }
}
