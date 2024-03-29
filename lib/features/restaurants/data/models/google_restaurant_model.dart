class GoogleRestaurantModel {
  GoogleRestaurantModel({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.priceLevel,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  String? businessStatus;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  OpeningHours? openingHours;
  List<Photo>? photos;
  String? placeId;
  PlusCode? plusCode;
  int? priceLevel;
  double? rating;
  String? reference;
  String? scope;
  List<String>? types;
  int? userRatingsTotal;
  String? vicinity;

  factory GoogleRestaurantModel.fromJson(Map<String, dynamic>? json) => GoogleRestaurantModel(
        businessStatus: json?["business_status"],
        geometry: Geometry.fromJson(json?["geometry"]),
        icon: json?["icon"],
        iconBackgroundColor: json?["icon_background_color"],
        iconMaskBaseUri: json?["icon_mask_base_uri"],
        name: json?["name"],
        openingHours: OpeningHours.fromJson(json?["opening_hours"]),
        photos: json?["photos"] == null ? [] : List<Photo>.from(json?["photos"].map((x) => Photo.fromJson(x))),
        placeId: json?["place_id"],
        plusCode: PlusCode.fromJson(json?["plus_code"]),
        priceLevel: json?["price_level"],
        rating: json?["rating"]?.toDouble(),
        reference: json?["reference"],
        scope: json?["scope"],
        types: json?["types"] == null ? [] : List<String>.from(json?["types"].map((x) => x)),
        userRatingsTotal: json?["user_ratings_total"],
        vicinity: json?["vicinity"],
      );

  // Map<String, dynamic> toJson() => {
  //   "business_status": businessStatus,
  //   "geometry": geometry.toJson(),
  //   "icon": icon,
  //   "icon_background_color": iconBackgroundColor,
  //   "icon_mask_base_uri": iconMaskBaseUri,
  //   "name": name,
  //   "opening_hours": openingHours.toJson(),
  //   "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
  //   "place_id": placeId,
  //   "plus_code": plusCode.toJson(),
  //   "price_level": priceLevel,
  //   "rating": rating,
  //   "reference": reference,
  //   "scope": scope,
  //   "types": List<dynamic>.from(types.map((x) => x)),
  //   "user_ratings_total": userRatingsTotal,
  //   "vicinity": vicinity,
  // };
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  Location? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic>? json) => Geometry(
        location: Location.fromJson(json?["location"]),
        viewport: Viewport.fromJson(json?["viewport"]),
      );

  // Map<String, dynamic> toJson() => {
  //   "location": location.toJson(),
  //   "viewport": viewport.toJson(),
  // };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic>? json) => Location(
        lat: json?["lat"]?.toDouble(),
        lng: json?["lng"]?.toDouble(),
      );

  // Map<String, dynamic> toJson() => {
  //   "lat": lat,
  //   "lng": lng,
  // };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic>? json) => Viewport(
        northeast: Location.fromJson(json?["northeast"]),
        southwest: Location.fromJson(json?["southwest"]),
      );

  // Map<String, dynamic> toJson() => {
  //   "northeast": northeast.toJson(),
  //   "southwest": southwest.toJson(),
  // };
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
  });

  bool? openNow;

  factory OpeningHours.fromJson(Map<String, dynamic>? json) => OpeningHours(
        openNow: json?["open_now"],
      );

  // Map<String, dynamic> toJson() => {
  //   "open_now": openNow,
  // };
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory Photo.fromJson(Map<String, dynamic>? json) => Photo(
        height: json?["height"],
        htmlAttributions:
            json?["html_attributions"] == null ? [] : List<String>.from(json?["html_attributions"].map((x) => x)),
        photoReference: json?["photo_reference"],
        width: json?["width"],
      );

  // Map<String, dynamic> toJson() => {
  //   "height": height,
  //   "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
  //   "photo_reference": photoReference,
  //   "width": width,
  // };
}

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic>? json) => PlusCode(
        compoundCode: json?["compound_code"],
        globalCode: json?["global_code"],
      );

  // Map<String, dynamic> toJson() => {
  //   "compound_code": compoundCode,
  //   "global_code": globalCode,
  // };
}
