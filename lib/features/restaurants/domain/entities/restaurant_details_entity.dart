import '../../data/models/yelp_restaurant_details_model.dart';

class RestaurantDetailsEntity {
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

  RestaurantDetailsEntity({
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
  });
}

class HourEntity {
  HourEntity({
    required this.open,
    required this.hoursType,
    required this.isOpenNow,
  });

  List<OpenEntity> open;
  String hoursType;
  bool isOpenNow;
}

class CategoryEntity {
  CategoryEntity({
    required this.alias,
    required this.title,
  });

  String? alias;
  String? title;
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

class OpenEntity {
  OpenEntity({
    required this.isOvernight,
    required this.start,
    required this.end,
    required this.day,
  });

  bool isOvernight;
  String start;
  String end;
  int day;
}

class CoordinatesEntity {
  CoordinatesEntity({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;
}
