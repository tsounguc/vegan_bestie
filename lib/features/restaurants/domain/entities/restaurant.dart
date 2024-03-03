import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.isOpenNow,
    required this.vicinity,
    required this.lat,
    required this.lng,
  });

  const Restaurant.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
          imageUrl: '_empty.imageUrl',
          distance: 0,
          price: '_empty.price',
          rating: 0,
          reviewCount: 0,
          isOpenNow: false,
          vicinity: '_empty.',
          lat: 0,
          lng: 0,
        );

  final String id;
  final String name;
  final String imageUrl;
  final bool isOpenNow;
  final double distance;
  final String price;
  final double rating;
  final int reviewCount;
  final String vicinity;
  final double lat;
  final double lng;

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        isOpenNow,
        distance,
        price,
        rating,
        reviewCount,
        vicinity,
        lat,
        lng,
      ];
}
