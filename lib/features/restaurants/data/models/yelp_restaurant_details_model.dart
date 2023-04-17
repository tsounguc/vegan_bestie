class YelpRestaurantDetailsModel {
  YelpRestaurantDetailsModel({
    required this.id,
    required this.alias,
    required this.name,
    required this.imageUrl,
    required this.isClaimed,
    required this.isClosed,
    required this.url,
    required this.phone,
    required this.displayPhone,
    required this.reviewCount,
    required this.categories,
    required this.rating,
    required this.location,
    required this.coordinates,
    required this.photos,
    required this.price,
    required this.hours,
    required this.transactions,
  });

  String? id;
  String? alias;
  String? name;
  String? imageUrl;
  bool? isClaimed;
  bool? isClosed;
  String? url;
  String? phone;
  String? displayPhone;
  int? reviewCount;
  List<Category>? categories;
  double? rating;
  Location? location;
  Coordinates? coordinates;
  List<String>? photos;
  String? price;
  List<Hour>? hours;
  List<String>? transactions;

  factory YelpRestaurantDetailsModel.fromJson(Map<String, dynamic>? json) => YelpRestaurantDetailsModel(
        id: json?["id"],
        alias: json?["alias"],
        name: json?["name"],
        imageUrl: json?["image_url"],
        isClaimed: json?["is_claimed"],
        isClosed: json?["is_closed"],
        url: json?["url"],
        phone: json?["phone"],
        displayPhone: json?["display_phone"],
        reviewCount: json?["review_count"],
        categories: json?["categories"] == null
            ? []
            : List<Category>.from(json?["categories"].map((x) => Category.fromJson(x))),
        rating: json?["rating"]?.toDouble(),
        location: Location.fromJson(json?["location"]),
        coordinates: Coordinates.fromJson(json?["coordinates"]),
        photos: json?["photos"] == null ? [] : List<String>.from(json?["photos"].map((x) => x)),
        price: json?["price"],
        hours: json?["hours"] == null ? [] : List<Hour>.from(json?["hours"].map((x) => Hour.fromJson(x))),
        transactions: List<String>.from(json?["transactions"].map((x) => x)),
      );
//
// Map<String, dynamic> toJson() => {
//       "id": id,
//       "alias": alias,
//       "name": name,
//       "image_url": imageUrl,
//       "is_claimed": isClaimed,
//       "is_closed": isClosed,
//       "url": url,
//       "phone": phone,
//       "display_phone": displayPhone,
//       "review_count": reviewCount,
//       "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
//       "rating": rating,
//       "location": location?.toJson(),
//       "coordinates": coordinates?.toJson(),
//       "photos": List<dynamic>.from(photos!.map((x) => x)),
//       "price": price,
//       "hours": List<dynamic>.from(hours!.map((x) => x.toJson())),
//       "transactions": List<dynamic>.from(transactions!.map((x) => x)),
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
        latitude: json?["latitude"]?.toDouble(),
        longitude: json?["longitude"]?.toDouble(),
      );

// Map<String, dynamic> toJson() => {
//       "latitude": latitude,
//       "longitude": longitude,
//     };
}

class Hour {
  Hour({
    required this.open,
    required this.hoursType,
    required this.isOpenNow,
  });

  List<Open>? open;
  String? hoursType;
  bool? isOpenNow;

  factory Hour.fromJson(Map<String, dynamic>? json) => Hour(
        open: json?["open"] == null ? [] : List<Open>.from(json?["open"].map((x) => Open.fromJson(x))),
        hoursType: json?["hours_type"],
        isOpenNow: json?["is_open_now"],
      );

// Map<String, dynamic> toJson() => {
//       "open": List<dynamic>.from(open.map((x) => x.toJson())),
//       "hours_type": hoursType,
//       "is_open_now": isOpenNow,
//     };
}

class Open {
  Open({
    required this.isOvernight,
    required this.start,
    required this.end,
    required this.day,
  });

  bool? isOvernight;
  String? start;
  String? end;
  int? day;

  factory Open.fromJson(Map<String, dynamic>? json) => Open(
        isOvernight: json?["is_overnight"],
        start: json?["start"],
        end: json?["end"],
        day: json?["day"],
      );

// Map<String, dynamic> toJson() => {
//       "is_overnight": isOvernight,
//       "start": start,
//       "end": end,
//       "day": day,
//     };
}

class Location {
  Location({
    required this.address1,
    this.address2,
    required this.address3,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.state,
    required this.displayAddress,
    required this.crossStreets,
  });

  String? address1;
  dynamic address2;
  String? address3;
  String? city;
  String? zipCode;
  String? country;
  String? state;
  List<String>? displayAddress;
  String? crossStreets;

  factory Location.fromJson(Map<String, dynamic>? json) => Location(
        address1: json?["address1"],
        address2: json?["address2"],
        address3: json?["address3"],
        city: json?["city"],
        zipCode: json?["zip_code"],
        country: json?["country"],
        state: json?["state"],
        displayAddress:
            json?["display_address"] == null ? [] : List<String>.from(json?["display_address"].map((x) => x)),
        crossStreets: json?["cross_streets"],
      );

// Map<String, dynamic> toJson() => {
//       "address1": address1,
//       "address2": address2,
//       "address3": address3,
//       "city": city,
//       "zip_code": zipCode,
//       "country": country,
//       "state": state,
//       "display_address": List<dynamic>.from(displayAddress.map((x) => x)),
//       "cross_streets": crossStreets,
//     };
}
