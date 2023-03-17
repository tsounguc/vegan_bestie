class RestaurantEntity {
  //TODO: complete RestaurantEntity class
  String? name;
  List<CategoryEntity>? categories;
  String? url;
  String? imageUrl;
  double? distance;
  LocationEntity? location;
  String? price;
  double? rating;
  int? reviewCount;
  RestaurantEntity({
    required this.name,
    required this.categories,
    required this.url,
    required this.imageUrl,
    required this.distance,
    required this.location,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });
}

class CategoryEntity {
  CategoryEntity({
    required this.alias,
    required this.title,
  });

  String? alias;
  String? title;

  // factory CategoryEntity.fromJson(Map<String, dynamic>? json) => Category(
  //   alias: json?["alias"],
  //   title: json?["title"],
  // );

// Map<String, dynamic> toJson() => {
//       "alias": alias,
//       "title": title,
//     };
}

class LocationEntity {
  LocationEntity({
    required this.address1,
    required this.address2,
    required this.address3,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.state,
    required this.displayAddress,
  });

  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? zipCode;
  String? country;
  String? state;
  List<String>? displayAddress;

  // factory Location.fromJson(Map<String, dynamic>? json) => Location(
  //   address1: json?["address1"],
  //   address2: json?["address2"],
  //   address3: json?["address3"],
  //   city: json?["city"],
  //   zipCode: json?["zip_code"],
  //   country: json?["country"],
  //   state: json?["state"],
  //   displayAddress: List<String>.from(json?["display_address"].map((x) => x)),
  // );

// Map<String, dynamic> toJson() => {
//       "address1": address1,
//       "address2": address2 == null ? null : address2Values.reverse[address2],
//       "address3": address3 == null ? null : address3,
//       "city": city,
//       "zip_code": zipCode,
//       "country": countryValues.reverse[country],
//       "state": stateValues.reverse[state],
//       "display_address": List<dynamic>.from(displayAddress.map((x) => x)),
//     };
}
