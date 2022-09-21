class Restaurant {
  String? locationId;
  String? name;
  String? latitude;
  String? longitude;
  String? numReviews;
  String? timeZone;
  String? locationString;
  Photo? photo;
  String? distanceText;
  String? rating;
  bool? isClosed;
  String? openNowText;
  bool? isLongClosed;
  String? priceLevel;
  String? description;
  String? webUrl;
  String? writeReview;
  String? phone;
  String? website;
  String? email;
  AddressObj? addressObj;
  String? addressText;
  Hours? hours;
  List<CuisineItem>? cuisine;
  List<DietaryRestriction>? dietaryRestrictions;
  Restaurant({
    required this.locationId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.numReviews,
    required this.timeZone,
    required this.locationString,
    required this.photo,
    required this.distanceText,
    required this.rating,
    required this.isClosed,
    required this.openNowText,
    required this.isLongClosed,
    required this.priceLevel,
    required this.description,
    required this.webUrl,
    required this.writeReview,
    required this.phone,
    required this.website,
    required this.email,
    required this.addressObj,
    required this.addressText,
    required this.hours,
    required this.cuisine,
    required this.dietaryRestrictions,
  });

  factory Restaurant.fromJson(Map<String, dynamic>? json) => Restaurant(
      locationId: json?['location_id'],
      name: json?['name'],
      latitude: json?['latitude'],
      longitude: json?['longitude'],
      numReviews: json?['num_reviews'],
      timeZone: json?['timezone'],
      locationString: json?['location_string'],
      photo: Photo.fromJson(json?['photo']),
      distanceText: json?['distance_string'],
      rating: json?['rating'],
      isClosed: json?['is_closed'],
      openNowText: json?['open_now_text'],
      isLongClosed: json?['is_long_closed'],
      priceLevel: json?['price_level'],
      description: json?['description'],
      webUrl: json?['web_url'],
      writeReview: json?['write_review'],
      phone: json?['phone'],
      website: json?['website'],
      email: json?['email'],
      addressObj: AddressObj.fromJson(json?['address_obj']),
      addressText: json?['address'],
      hours: Hours.fromJson(json?['hours']),
      cuisine: List<CuisineItem>.from(json?['cuisine'].map((cuisineItem) => CuisineItem.fromJson(cuisineItem))),
      dietaryRestrictions: List<DietaryRestriction>.from(json?['dietary_restrictions']
          .map((dietaryRestriction) => DietaryRestriction.fromJson(dietaryRestriction))));
}

class Photo {
  Images? images;
  Photo({
    required this.images,
  });
  factory Photo.fromJson(Map<String, dynamic>? json) => Photo(
        images: Images.fromJson(json?['images']),
      );
}

class Images {
  ImageType? small;
  ImageType? medium;
  ImageType? large;
  ImageType? thumbnail;
  ImageType? original;

  Images({
    required this.small,
    required this.medium,
    required this.large,
    required this.thumbnail,
    required this.original,
  });

  factory Images.fromJson(Map<String, dynamic>? json) => Images(
        small: ImageType.fromJson(json?['small']),
        medium: ImageType.fromJson(json?['medium']),
        large: ImageType.fromJson(json?['large']),
        thumbnail: ImageType.fromJson(json?['thumbnail']),
        original: ImageType.fromJson(json?['original']),
      );
}

class ImageType {
  String? width;
  String? height;
  String? url;
  ImageType({
    required this.width,
    required this.height,
    required this.url,
  });

  factory ImageType.fromJson(Map<String, dynamic>? json) => ImageType(
        width: json?['width'],
        height: json?['height'],
        url: json?['url'],
      );
}

class AddressObj {
  String? street1;
  String? street2;
  String? city;
  String? state;
  String? country;
  String? postalcode;
  AddressObj({
    required this.street1,
    required this.street2,
    required this.city,
    required this.state,
    required this.country,
    required this.postalcode,
  });

  factory AddressObj.fromJson(json) => AddressObj(
        street1: json?['street1'],
        street2: json?['street2'],
        city: json?['city'],
        state: json?['state'],
        country: json?['country'],
        postalcode: json?['postalcode'],
      );
}

class Hours {
  // List<List<Map<String, int>?>?>? weekRanges;
  List<List<Times>?>? weekRanges;
  String? timezone;
  Hours({
    required this.weekRanges,
    required this.timezone,
  });

  factory Hours.fromJson(Map<String, dynamic>? json) => Hours(
        weekRanges: json?['week_ranges'] != null
            ? List<List<Times>>.from(
                json?['week_ranges'].map(
                  (dayArray) => List<Times>.from(
                    dayArray.map((timesObject) => Times.fromJson(timesObject)),
                  ),
                ),
              )
            : [],
        timezone: json?['timezone'],
      );
}

class Times {
  int? openTime;
  int? closeTime;
  Times({this.openTime, this.closeTime});

  factory Times.fromJson(Map<String, dynamic>? json) => Times(
        openTime: json?['open_time'],
        closeTime: json?['close_time'],
      );
}

class CuisineItem {
  String? key;
  String? name;
  CuisineItem({required this.key, required this.name});

  factory CuisineItem.fromJson(Map<String, dynamic>? json) => CuisineItem(
        key: json?['key'],
        name: json?['name'],
      );
}

class DietaryRestriction {
  String? key;
  String? name;

  DietaryRestriction({required this.key, required this.name});

  factory DietaryRestriction.fromJson(Map<String, dynamic>? json) => DietaryRestriction(
        key: json?['key'],
        name: json?['name'],
      );
}
