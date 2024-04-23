import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/common/entities/restaurant_entities.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.icon,
    required this.name,
    required this.photos,
    required this.distance,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.openingHours,
    required this.vicinity,
    required this.geometry,
    required this.servesVegetarianFood,
  });

  Restaurant.empty()
      : this(
          id: '_empty.id',
          icon: '_empty.id',
          name: '_empty.name',
          photos: [],
          distance: 0,
          price: '_empty.price',
          rating: 0,
          reviewCount: 0,
          openingHours: OpeningHours.empty(),
          vicinity: '_empty.',
          geometry: const Geometry.empty(),
          servesVegetarianFood: false,
        );

  final String id;
  final String icon;
  final String name;
  final List<Photo> photos;
  final OpeningHours openingHours;
  final double distance;
  final String price;
  final double rating;
  final int reviewCount;
  final String vicinity;
  final Geometry geometry;
  final bool servesVegetarianFood;

  @override
  List<Object?> get props => [
        id,
        icon,
        name,
        photos,
        openingHours,
        distance,
        price,
        rating,
        reviewCount,
        vicinity,
        geometry,
        servesVegetarianFood,
      ];
}
