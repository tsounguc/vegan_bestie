import 'dart:convert';

import 'package:sheveegan/core/common/entities/restaurant_entities.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_details_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';

class RestaurantEntityModel extends RestaurantEntity {
  const RestaurantEntityModel({
    required super.id,
    required super.icon,
    required super.name,
    // required super.distance,
    required super.photos,
    required super.price,
    required super.rating,
    required super.reviewCount,
    required super.openingHours,
    required super.vicinity,
    required super.geometry,
    required super.servesVegetarianFood,
  });

  RestaurantEntityModel.empty()
      : this(
          id: '_empty.id',
          icon: '_empty.icon',
          name: '_empty.name',
          // distance: 0,
          photos: [],
          price: 0,
          rating: 0,
          reviewCount: 0,
          openingHours: OpeningHoursModel.empty(),
          vicinity: '_empty.vicinity',
          geometry: const Geometry.empty(),
          servesVegetarianFood: true,
        );

  factory RestaurantEntityModel.fromJson(String source) => RestaurantEntityModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  RestaurantEntityModel.fromMap(DataMap dataMap)
      : this(
          id: dataMap['place_id'] == null ? '' : dataMap['place_id'] as String,
          icon: dataMap['icon'] == null ? '' : dataMap['icon'] as String,
          name: dataMap['name'] == null ? '' : dataMap['name'] as String,
          // distance: double.tryParse(dataMap['distance'].toString()) ?? 0.0,
          photos: dataMap['photos'] == null
              ? []
              : List<PhotoModel>.from(
                  (dataMap['photos'] as List).map(
                    (photo) => PhotoModel.fromMap(
                      photo as DataMap,
                    ),
                  ),
                ),
          price: dataMap['price_level'] as int? ?? 0,
          rating: double.tryParse(dataMap['rating'].toString()) ?? 0.0,
          reviewCount: int.tryParse(
                dataMap['user_ratings_total'].toString(),
              ) ??
              0,
          openingHours: dataMap['opening_hours'] == null
              ? OpeningHoursModel.empty()
              : OpeningHoursModel.fromMap(
                  dataMap['opening_hours'] as DataMap,
                ),
          vicinity: dataMap['vicinity'] == null ? '' : dataMap['vicinity'] as String,
          geometry: dataMap['geometry'] == null
              ? const GeometryModel.empty()
              : GeometryModel.fromMap(dataMap['geometry'] as DataMap),
          servesVegetarianFood:
              dataMap['serves_vegetarian_food'] == null ? false : dataMap['serves_vegetarian_food'] as bool,
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'place_id': id,
        'icon': icon,
        'name': name,
        // 'distance': distance,
        'photos': List<dynamic>.from(
          photos.map(
            (photo) => (photo as PhotoModel).toMap(),
          ),
        ),
        'price': price,
        'rating': rating,
        'user_ratings_total': reviewCount,
        'opening_hours': (openingHours as OpeningHoursModel).toMap(),
        'vicinity': vicinity,
        'geometry': (geometry as GeometryModel).toMap(),
        'serves_vegetarian_food': servesVegetarianFood,
      };

  RestaurantEntityModel copyWith({
    String? id,
    String? icon,
    String? name,
    // double? distance,
    List<Photo>? photos,
    int? price,
    double? rating,
    int? reviewCount,
    OpeningHours? openingHours,
    String? vicinity,
    Geometry? geometry,
    bool? servesVegetarianFood,
  }) {
    return RestaurantEntityModel(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      // distance: distance ?? this.distance,
      photos: photos ?? this.photos,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      openingHours: openingHours ?? this.openingHours,
      vicinity: vicinity ?? this.vicinity,
      geometry: geometry ?? this.geometry,
      servesVegetarianFood: servesVegetarianFood ?? this.servesVegetarianFood,
    );
  }
}

class GeometryModel extends Geometry {
  const GeometryModel({required super.location, required super.viewport});

  factory GeometryModel.fromJson(String source) => GeometryModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  const GeometryModel.empty()
      : this(
          location: const Location.empty(),
          viewport: const Viewport.empty(),
        );

  GeometryModel.fromMap(DataMap dataMap)
      : this(
          location: LocationModel.fromMap(dataMap['location'] as DataMap),
          viewport: ViewportModel.fromMap(dataMap['viewport'] as DataMap),
        );

  DataMap toMap() => {
        'location': (location as LocationModel).toMap(),
        'viewport': (viewport as ViewportModel).toMap(),
      };
}

class LocationModel extends Location {
  const LocationModel({
    required super.lat,
    required super.lng,
  });

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  LocationModel.fromMap(DataMap dataMap)
      : this(
          lat: double.tryParse(dataMap['lat'].toString()) ?? 0.0,
          lng: double.tryParse(dataMap['lng'].toString()) ?? 0.0,
        );

  DataMap toMap() => {
        'lat': lat,
        'lng': lng,
      };
}

class ViewportModel extends Viewport {
  const ViewportModel({
    required super.northeast,
    required super.southwest,
  });

  factory ViewportModel.fromJson(String source) => ViewportModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  ViewportModel.fromMap(DataMap dataMap)
      : this(
          northeast: LocationModel.fromMap(dataMap['northeast'] as DataMap),
          southwest: LocationModel.fromMap(dataMap['southwest'] as DataMap),
        );

  DataMap toMap() => {
        'northeast': (northeast as LocationModel).toMap(),
        'southwest': (southwest as LocationModel).toMap(),
      };
}

class PhotoModel extends Photo {
  const PhotoModel({
    required super.height,
    required super.htmlAttributions,
    required super.photoReference,
    required super.width,
  });

  factory PhotoModel.fromJson(String source) => PhotoModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  PhotoModel.fromMap(DataMap dataMap)
      : this(
          height: int.tryParse(dataMap['height'].toString()) ?? 0,
          width: int.tryParse(dataMap['width'].toString()) ?? 0,
          htmlAttributions: List<String>.from(
            (dataMap['html_attributions'] as List).map(
              (attribution) => attribution.toString(),
            ),
          ),
          photoReference: dataMap['photo_reference'] as String,
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'height': height,
        'width': width,
        'html_attributions': htmlAttributions,
        'photo_reference': photoReference,
      };
}

// class GoogleRestaurantModel {
//   GoogleRestaurantModel({
//     required this.businessStatus,
//     required this.geometry,
//     required this.icon,
//     required this.iconBackgroundColor,
//     required this.iconMaskBaseUri,
//     required this.name,
//     required this.openingHours,
//     required this.photos,
//     required this.placeId,
//     required this.plusCode,
//     required this.priceLevel,
//     required this.rating,
//     required this.reference,
//     required this.scope,
//     required this.types,
//     required this.userRatingsTotal,
//     required this.vicinity,
//   });
//
//   String? businessStatus;
//   Geometry? geometry;
//   String? icon;
//   String? iconBackgroundColor;
//   String? iconMaskBaseUri;
//   String? name;
//   OpeningHours? openingHours;
//   List<Photo>? photos;
//   String? placeId;
//   PlusCode? plusCode;
//   int? priceLevel;
//   double? rating;
//   String? reference;
//   String? scope;
//   List<String>? types;
//   int? userRatingsTotal;
//   String? vicinity;
//
//   factory GoogleRestaurantModel.fromJson(Map<String, dynamic>? json) => GoogleRestaurantModel(
//         businessStatus: json?["business_status"],
//         geometry: Geometry.fromJson(json?["geometry"]),
//         icon: json?["icon"],
//         iconBackgroundColor: json?["icon_background_color"],
//         iconMaskBaseUri: json?["icon_mask_base_uri"],
//         name: json?["name"],
//         openingHours: OpeningHours.fromJson(json?["opening_hours"]),
//         photos: json?["photos"] == null ? [] : List<Photo>.from(json?["photos"].map((x) => Photo.fromJson(x))),
//         placeId: json?["place_id"],
//         plusCode: PlusCode.fromJson(json?["plus_code"]),
//         priceLevel: json?["price_level"],
//         rating: json?["rating"]?.toDouble(),
//         reference: json?["reference"],
//         scope: json?["scope"],
//         types: json?["types"] == null ? [] : List<String>.from(json?["types"].map((x) => x)),
//         userRatingsTotal: json?["user_ratings_total"],
//         vicinity: json?["vicinity"],
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //   "business_status": businessStatus,
//   //   "geometry": geometry.toJson(),
//   //   "icon": icon,
//   //   "icon_background_color": iconBackgroundColor,
//   //   "icon_mask_base_uri": iconMaskBaseUri,
//   //   "name": name,
//   //   "opening_hours": openingHours.toJson(),
//   //   "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
//   //   "place_id": placeId,
//   //   "plus_code": plusCode.toJson(),
//   //   "price_level": priceLevel,
//   //   "rating": rating,
//   //   "reference": reference,
//   //   "scope": scope,
//   //   "types": List<dynamic>.from(types.map((x) => x)),
//   //   "user_ratings_total": userRatingsTotal,
//   //   "vicinity": vicinity,
//   // };
// }
//
// class Geometry {
//   Geometry({
//     required this.location,
//     required this.viewport,
//   });
//
//   Location? location;
//   Viewport? viewport;
//
//   factory Geometry.fromJson(Map<String, dynamic>? json) => Geometry(
//         location: Location.fromJson(json?["location"]),
//         viewport: Viewport.fromJson(json?["viewport"]),
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //   "location": location.toJson(),
//   //   "viewport": viewport.toJson(),
//   // };
// }
//
// class Location {
//   Location({
//     required this.lat,
//     required this.lng,
//   });
//
//   double? lat;
//   double? lng;
//
//   factory Location.fromJson(Map<String, dynamic>? json) => Location(
//         lat: json?["lat"]?.toDouble(),
//         lng: json?["lng"]?.toDouble(),
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //   "lat": lat,
//   //   "lng": lng,
//   // };
// }
//
// class Viewport {
//   Viewport({
//     required this.northeast,
//     required this.southwest,
//   });
//
//   Location? northeast;
//   Location? southwest;
//
//   factory Viewport.fromJson(Map<String, dynamic>? json) => Viewport(
//         northeast: Location.fromJson(json?["northeast"]),
//         southwest: Location.fromJson(json?["southwest"]),
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //   "northeast": northeast.toJson(),
//   //   "southwest": southwest.toJson(),
//   // };
// }
//
// class OpeningHours {
//   OpeningHours({
//     required this.openNow,
//   });
//
//   bool? openNow;
//
//   factory OpeningHours.fromJson(Map<String, dynamic>? json) => OpeningHours(
//         openNow: json?["open_now"],
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //   "open_now": openNow,
//   // };
// }
//
// class Photo {
//   Photo({
//     required this.height,
//     required this.htmlAttributions,
//     required this.photoReference,
//     required this.width,
//   });
//
//   int? height;
//   List<String>? htmlAttributions;
//   String? photoReference;
//   int? width;
//
//   factory Photo.fromJson(Map<String, dynamic>? json) => Photo(
//         height: json?["height"],
//         htmlAttributions:
//             json?["html_attributions"] == null ? [] : List<String>.from(json?["html_attributions"].map((x) => x)),
//         photoReference: json?["photo_reference"],
//         width: json?["width"],
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //   "height": height,
//   //   "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
//   //   "photo_reference": photoReference,
//   //   "width": width,
//   // };
// }
//
// class PlusCode {
//   PlusCode({
//     required this.compoundCode,
//     required this.globalCode,
//   });
//
//   String? compoundCode;
//   String? globalCode;
//
//   factory PlusCode.fromJson(Map<String, dynamic>? json) => PlusCode(
//         compoundCode: json?["compound_code"],
//         globalCode: json?["global_code"],
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //   "compound_code": compoundCode,
//   //   "global_code": globalCode,
//   // };
// }
