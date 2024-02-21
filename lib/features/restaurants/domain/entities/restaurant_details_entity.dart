import '../../../../core/restaurant_details_models.dart';

class RestaurantDetailsEntity {
  RestaurantDetailsEntity({
    required this.addressComponents,
    required this.adrAddress,
    required this.businessStatus,
    required this.currentOpeningHours,
    required this.delivery,
    required this.dineIn,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.geometry,
    required this.imageUrl,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.internationalPhoneNumber,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.rating,
    required this.reference,
    required this.reservable,
    required this.reviews,
    required this.servesBeer,
    required this.servesDinner,
    required this.servesLunch,
    required this.servesVegetarianFood,
    required this.servesWine,
    required this.takeout,
    required this.types,
    required this.url,
    required this.userRatingsTotal,
    required this.utcOffset,
    required this.vicinity,
    required this.website,
    required this.wheelchairAccessibleEntrance,
  });

  List<AddressComponent>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  CurrentOpeningHours? currentOpeningHours;
  bool? delivery;
  bool? dineIn;
  String? formattedAddress;
  String? formattedPhoneNumber;
  Geometry? geometry;
  String? imageUrl;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? internationalPhoneNumber;
  String? name;
  OpeningHours? openingHours;
  List<Photo>? photos;
  String? placeId;
  PlusCode? plusCode;
  double? rating;
  String? reference;
  bool? reservable;
  List<Review>? reviews;
  bool? servesBeer;
  bool? servesDinner;
  bool? servesLunch;
  bool? servesVegetarianFood;
  bool? servesWine;
  bool? takeout;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;
  String? website;
  bool? wheelchairAccessibleEntrance;
}

// import '../../data/models/yelp_restaurant_details_model.dart';

// class RestaurantDetailsEntity {
//   String? id;
//   // String? alias;
//   String? name;
//   // String? imageUrl;
//   List<PhotoEntity> photos;
//   bool? isClaimed;
//   bool? isClosed;
//   String? url;
//   String? phone;
//   String? displayPhone;
//   int? reviewCount;
//   List<Category>? categories;
//   double? rating;
//   Location? location;
//   Coordinates? coordinates;
//   String? price;
//   List<Hour>? hours;
//   List<String>? transactions;
//
//   RestaurantDetailsEntity({
//     required this.id,
//     // required this.alias,
//     required this.photos,
//     required this.name,
//     // required this.imageUrl,
//     required this.isClaimed,
//     required this.isClosed,
//     required this.url,
//     required this.phone,
//     required this.displayPhone,
//     required this.reviewCount,
//     required this.categories,
//     required this.rating,
//     required this.location,
//     required this.coordinates,
//     required this.price,
//     required this.hours,
//   });
// }
//
// class HourEntity {
//   HourEntity({
//     required this.open,
//     required this.hoursType,
//     required this.isOpenNow,
//   });
//
//   List<OpenEntity> open;
//   String hoursType;
//   bool isOpenNow;
// }
//
// class CategoryEntity {
//   CategoryEntity({
//     required this.alias,
//     required this.title,
//   });
//
//   String? alias;
//   String? title;
// }
//
// class LocationEntity {
//   LocationEntity({
//     required this.address1,
//     required this.address2,
//     required this.address3,
//     required this.city,
//     required this.zipCode,
//     required this.country,
//     required this.state,
//     required this.displayAddress,
//   });
//
//   String? address1;
//   String? address2;
//   String? address3;
//   String? city;
//   String? zipCode;
//   String? country;
//   String? state;
//   List<String>? displayAddress;
// }
//
// class OpenEntity {
//   OpenEntity({
//     required this.isOvernight,
//     required this.start,
//     required this.end,
//     required this.day,
//   });
//
//   bool isOvernight;
//   String start;
//   String end;
//   int day;
// }
//
// class CoordinatesEntity {
//   CoordinatesEntity({
//     required this.latitude,
//     required this.longitude,
//   });
//
//   double latitude;
//   double longitude;
// }
// class PhotoEntity {
//   PhotoEntity({
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
// }
