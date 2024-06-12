import 'dart:convert';

import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.contactName,
    required super.email,
    required super.streetAddress,
    required super.city,
    required super.state,
    required super.zipCode,
    required super.county,
    required super.areaCode,
    required super.phoneNumber,
    required super.geoLocation,
    required super.websiteUrl,
    required super.openingHours,
    required super.photos,
    required super.price,
    required super.veganStatus,
    required super.hasVeganOptions,
    super.description,
    super.image,
    super.imageIsFile = false,
  });

  const RestaurantModel.empty()
      : this(
          id: '_empty.id',
          image: null,
          name: '_empty.name',
          contactName: '_empty.contactName',
          email: '_empty.email',
          streetAddress: '_empty.streetAddress',
          city: '_empty.city',
          state: '_empty.state',
          zipCode: '_empty.zipCode',
          county: '_empty.county',
          areaCode: '_empty.areaCode',
          phoneNumber: '_empty.phoneNumber',
          websiteUrl: '_empty.websiteUrl',
          geoLocation: const GeoLocationModel.empty(),
          openingHours: const [],
          photos: const [],
          price: '_empty.price',
          veganStatus: false,
          hasVeganOptions: false,
          description: null,
        );

  factory RestaurantModel.fromJson(String source) => RestaurantModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  RestaurantModel.fromMap(DataMap dataMap)
      : this(
          id: '_empty.id',
          image: dataMap['image'] as String?,
          imageIsFile: dataMap['imageIsFile'] as bool? ?? false,
          description: dataMap['description'] as String?,
          name: dataMap['name'] as String,
          contactName: dataMap['contactName'] as String,
          email: dataMap['email'] as String,
          streetAddress: dataMap['streetAddress'] as String,
          city: dataMap['city'] as String,
          state: dataMap['state'] as String,
          zipCode: dataMap['zipCode'] as String,
          county: dataMap['county'] as String,
          areaCode: dataMap['areaCode'] as String,
          phoneNumber: dataMap['phoneNumber'] as String,
          websiteUrl: dataMap['websiteUrl'] as String,
          geoLocation: dataMap['geoLocation'] == null
              ? const GeoLocationModel.empty()
              : GeoLocationModel.fromMap(dataMap['geoLocation'] as DataMap),
          openingHours: List<String>.from(
            (dataMap['openingHours'] as List).map((openingHour) => openingHour),
          ),
          photos: List<String>.from(
            (dataMap['photos'] as List).map((photo) => photo),
          ),
          price: dataMap['price'] as String,
          veganStatus: dataMap['veganStatus'] as bool? ?? false,
          hasVeganOptions: dataMap['hasVeganOptions'] as bool? ?? false,
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'id': id,
        'image': image,
        'imageIsFile': imageIsFile,
        'description': description,
        'name': name,
        'contactName': contactName,
        'email': email,
        'streetAddress': streetAddress,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'county': county,
        'areaCode': areaCode,
        'phoneNumber': phoneNumber,
        'websiteUrl': websiteUrl,
        'openingHours': List<dynamic>.from(
          openingHours.map(
            (openingHour) => openingHour,
          ),
        ),
        'photos': List<dynamic>.from(
          photos.map(
            (photo) => photo,
          ),
        ),
        'price': price,
        'veganStatus': false,
        'hasVeganOptions': false,
      };

  RestaurantModel copyWith({
    String? id,
    String? image,
    bool? imageIsFile,
    String? description,
    String? name,
    String? contactName,
    String? email,
    String? streetAddress,
    String? city,
    String? state,
    String? zipCode,
    String? county,
    String? areaCode,
    String? phoneNumber,
    String? websiteUrl,
    GeoLocation? geoLocation,
    List<String>? openingHours,
    List<String>? photos,
    String? price,
    bool? veganStatus,
    bool? hasVeganOptions,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      image: image ?? this.image,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      description: description ?? this.description,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      county: county ?? this.county,
      areaCode: areaCode ?? this.areaCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      geoLocation: geoLocation ?? this.geoLocation,
      openingHours: openingHours ?? this.openingHours,
      photos: photos ?? this.photos,
      price: price ?? this.price,
      veganStatus: veganStatus ?? this.veganStatus,
      hasVeganOptions: hasVeganOptions ?? this.hasVeganOptions,
    );
  }
}

class GeoLocationModel extends GeoLocation {
  const GeoLocationModel({required super.lng, required super.lat});

  const GeoLocationModel.empty()
      : this(
          lat: 0,
          lng: 0,
        );

  factory GeoLocationModel.fromJson(String source) => GeoLocationModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  GeoLocationModel.fromMap(DataMap dataMap)
      : this(
          lat: double.tryParse(dataMap['lat'].toString()) ?? 0.0,
          lng: double.tryParse(dataMap['lng'].toString()) ?? 0.0,
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'lat': lat,
        'lng': lng,
      };
}
