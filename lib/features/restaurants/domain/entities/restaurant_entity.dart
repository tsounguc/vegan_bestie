class RestaurantEntity {
  //TODO: complete RestaurantEntity class
  String? id;
  String? name;
  List<CategoryEntity>? categories;
  String? url;
  String? imageUrl;

  // bool? isOpenNow;
  // List<HourEntity> hours;
  double? distance;
  LocationEntity? location;
  String? price;
  double? rating;
  int? reviewCount;
  String? phone;
  String? displayPhone;

  RestaurantEntity({
    required this.id,
    required this.name,
    required this.categories,
    required this.url,
    required this.imageUrl,
    required this.distance,
    required this.location,
    required this.price,
    required this.rating,
    required this.reviewCount,
    // required this.isOpenNow,
    // required this.hours,
    required this.displayPhone,
    required this.phone,
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
}

// class HourEntity {
//   HourEntity({
//     required this.hourType,
//     required this.openHours,
//     required this.isOpenNow,
//   });
//
//   String? hourType;
//   List<OpenHourEntity> openHours;
//   bool? isOpenNow;
// }
//
// class OpenHourEntity {
//   OpenHourEntity({
//     required this.day,
//     required this.start,
//     required this.end,
//     required this.isOvernight,
//   });
//
//   int? day;
//   String? start;
//   String? end;
//   bool? isOvernight;
// }
