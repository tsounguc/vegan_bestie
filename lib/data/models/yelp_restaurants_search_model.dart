// To parse this JSON data, do
//
//     final yelpRestaurantsSearchModel = yelpRestaurantsSearchModelFromJson(jsonString);

import 'dart:convert';

YelpRestaurantsSearchModel yelpRestaurantsSearchModelFromJson(String str) =>
    YelpRestaurantsSearchModel.fromJson(json.decode(str));

// String yelpRestaurantsSearchModelToJson(YelpRestaurantsSearchModel data) => json.encode(data.toJson());

class YelpRestaurantsSearchModel {
  YelpRestaurantsSearchModel({
    required this.businesses,
    required this.total,
    required this.region,
  });

  List<Business>? businesses;
  int? total;
  Region? region;

  factory YelpRestaurantsSearchModel.fromJson(Map<String, dynamic>? json) => YelpRestaurantsSearchModel(
        businesses: List<Business>.from(json?["businesses"].map((x) => Business.fromJson(x))),
        total: json?["total"],
        region: Region.fromJson(json?["region"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
  //       "total": total,
  //       "region": region.toJson(),
  //     };
}

class Business {
  Business({
    required this.id,
    required this.alias,
    required this.name,
    required this.imageUrl,
    required this.isClosed,
    required this.url,
    required this.reviewCount,
    required this.categories,
    required this.rating,
    required this.coordinates,
    required this.transactions,
    required this.price,
    required this.location,
    required this.phone,
    required this.displayPhone,
    required this.distance,
  });

  String? id;
  String? alias;
  String? name;
  String? imageUrl;
  bool? isClosed;
  String? url;
  int? reviewCount;
  List<Category>? categories;
  double? rating;
  Coordinates? coordinates;
  List<String>? transactions;
  String? price;
  Location? location;
  String? phone;
  String? displayPhone;
  double? distance;

  factory Business.fromJson(Map<String, dynamic>? json) => Business(
        id: json?["id"],
        alias: json?["alias"],
        name: json?["name"],
        imageUrl: json?["image_url"],
        isClosed: json?["is_closed"],
        url: json?["url"],
        reviewCount: json?["review_count"],
        categories: List<Category>.from(json?["categories"].map((x) => Category.fromJson(x))),
        rating: json?["rating"].toDouble(),
        coordinates: Coordinates.fromJson(json?["coordinates"]),
        transactions: List<String>.from(json?["transactions"].map((x) => x)),
        price: json?["price"],
        location: Location.fromJson(json?["location"]),
        phone: json?["phone"],
        displayPhone: json?["display_phone"],
        distance: json?["distance"].toDouble(),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "alias": alias,
  //       "name": name,
  //       "image_url": imageUrl,
  //       "is_closed": isClosed,
  //       "url": url,
  //       "review_count": reviewCount,
  //       "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  //       "rating": rating,
  //       "coordinates": coordinates.toJson(),
  //       "transactions": List<dynamic>.from(transactions.map((x) => transactionValues.reverse[x])),
  //       "price": price == null ? null : priceValues.reverse[price],
  //       "location": location.toJson(),
  //       "phone": phone,
  //       "display_phone": displayPhone,
  //       "distance": distance,
  //     };
}

class Category {
  Category({
    required this.alias,
    required this.title,
  });

  String? alias;
  String? title;

  factory Category.fromJson(Map<String, dynamic>? json) => Category(
        alias: json?["alias"],
        title: json?["title"],
      );

  // Map<String, dynamic> toJson() => {
  //       "alias": alias,
  //       "title": title,
  //     };
}

class Coordinates {
  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Coordinates.fromJson(Map<String, dynamic>? json) => Coordinates(
        latitude: json?["latitude"].toDouble(),
        longitude: json?["longitude"].toDouble(),
      );

  // Map<String, dynamic> toJson() => {
  //       "latitude": latitude,
  //       "longitude": longitude,
  //     };
}

class Location {
  Location({
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

  factory Location.fromJson(Map<String, dynamic>? json) => Location(
        address1: json?["address1"],
        address2: json?["address2"],
        address3: json?["address3"],
        city: json?["city"],
        zipCode: json?["zip_code"],
        country: json?["country"],
        state: json?["state"],
        displayAddress: List<String>.from(json?["display_address"].map((x) => x)),
      );

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

// enum Transaction { DELIVERY, PICKUP }

// final transactionValues = EnumValues({"delivery": Transaction.DELIVERY, "pickup": Transaction.PICKUP});

class Region {
  Region({
    required this.center,
  });

  Coordinates? center;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        center: Coordinates.fromJson(json["center"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "center": center.toJson(),
  //     };
}
