import '../../../../core/restaurant_details_models.dart';

class GoogleRestaurantDetailsModel {
  GoogleRestaurantDetailsModel({
    required this.addressComponents,
    required this.adrAddress,
    required this.businessStatus,
    required this.currentOpeningHours,
    required this.delivery,
    required this.dineIn,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.geometry,
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

  factory GoogleRestaurantDetailsModel.fromJson(Map<String, dynamic>? json) => GoogleRestaurantDetailsModel(
        addressComponents: json?["address_components"] == null
            ? []
            : List<AddressComponent>.from(json?["address_components"].map((x) => AddressComponent.fromJson(x))),
        adrAddress: json?["adr_address"],
        businessStatus: json?["business_status"],
        currentOpeningHours: CurrentOpeningHours.fromJson(json?["current_opening_hours"]),
        delivery: json?["delivery"],
        dineIn: json?["dine_in"],
        formattedAddress: json?["formatted_address"],
        formattedPhoneNumber: json?["formatted_phone_number"],
        geometry: Geometry.fromJson(json?["geometry"]),
        icon: json?["icon"],
        iconBackgroundColor: json?["icon_background_color"],
        iconMaskBaseUri: json?["icon_mask_base_uri"],
        internationalPhoneNumber: json?["international_phone_number"],
        name: json?["name"],
        openingHours: OpeningHours.fromJson(json?["opening_hours"]),
        photos: json?["photos"] == null ? [] : List<Photo>.from(json?["photos"].map((x) => Photo.fromJson(x))),
        placeId: json?["place_id"],
        plusCode: PlusCode.fromJson(json?["plus_code"]),
        rating: json?["rating"]?.toDouble(),
        reference: json?["reference"],
        reservable: json?["reservable"],
        reviews:
            json?["reviews"] == null ? [] : List<Review>.from(json?["reviews"].map((x) => Review.fromJson(x))),
        servesBeer: json?["serves_beer"],
        servesDinner: json?["serves_dinner"],
        servesLunch: json?["serves_lunch"],
        servesVegetarianFood: json?["serves_vegetarian_food"],
        servesWine: json?["serves_wine"],
        takeout: json?["takeout"],
        types: json?["types"] == null ? [] : List<String>.from(json?["types"].map((x) => x)),
        url: json?["url"],
        userRatingsTotal: json?["user_ratings_total"],
        utcOffset: json?["utc_offset"],
        vicinity: json?["vicinity"],
        website: json?["website"],
        wheelchairAccessibleEntrance: json?["wheelchair_accessible_entrance"],
      );

// Map<String, dynamic> toJson() => {
//   "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
//   "adr_address": adrAddress,
//   "business_status": businessStatus,
//   "current_opening_hours": currentOpeningHours.toJson(),
//   "delivery": delivery,
//   "dine_in": dineIn,
//   "formatted_address": formattedAddress,
//   "formatted_phone_number": formattedPhoneNumber,
//   "geometry": geometry.toJson(),
//   "icon": icon,
//   "icon_background_color": iconBackgroundColor,
//   "icon_mask_base_uri": iconMaskBaseUri,
//   "international_phone_number": internationalPhoneNumber,
//   "name": name,
//   "opening_hours": openingHours.toJson(),
//   "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
//   "place_id": placeId,
//   "plus_code": plusCode.toJson(),
//   "rating": rating,
//   "reference": reference,
//   "reservable": reservable,
//   "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
//   "serves_beer": servesBeer,
//   "serves_dinner": servesDinner,
//   "serves_lunch": servesLunch,
//   "serves_vegetarian_food": servesVegetarianFood,
//   "serves_wine": servesWine,
//   "takeout": takeout,
//   "types": List<dynamic>.from(types.map((x) => x)),
//   "url": url,
//   "user_ratings_total": userRatingsTotal,
//   "utc_offset": utcOffset,
//   "vicinity": vicinity,
//   "website": website,
//   "wheelchair_accessible_entrance": wheelchairAccessibleEntrance,
// };
}
