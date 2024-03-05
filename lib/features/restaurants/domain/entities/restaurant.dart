import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/common/entities/restaurant_entities.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.name,
    required this.photos,
    required this.distance,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.isOpenNow,
    required this.vicinity,
    required this.geometry,
  });

  Restaurant.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          photos: [],
          distance: 0,
          price: '_empty.price',
          rating: 0,
          reviewCount: 0,
          isOpenNow: false,
          vicinity: '_empty.',
          geometry: const Geometry.empty(),
        );

  final String id;
  final String name;
  final List<Photo> photos;
  final bool isOpenNow;
  final double distance;
  final String price;
  final double rating;
  final int reviewCount;
  final String vicinity;
  final Geometry geometry;

  @override
  List<Object?> get props =>
      [id, name, photos, isOpenNow, distance, price, rating, reviewCount, vicinity, geometry];
}
